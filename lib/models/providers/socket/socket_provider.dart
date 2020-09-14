import 'dart:convert';

import 'package:Nuvle/models/providers/user/order/orderProvider.dart';
import 'package:Nuvle/models/providers/user/userAccountProvider.dart';
import 'package:Nuvle/models/skeltons/menus/menuData.dart';
import 'package:Nuvle/pages/user/main/menus/myTab/myTab.dart';
import 'package:flutter/material.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/skeltons/user/tab.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/pages/user/scan/scanissuccess.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider extends ChangeNotifier {
  static final String baseUrl = 'https://nulve-node-api.herokuapp.com/api/v1';

  IO.Socket socket = IO.io(baseUrl, <String, dynamic>{
    'transports': ['websocket'],
  });

  openTab(String restaurantId, tableId, UserAccount userAccount,
      BuildContext context) {
    if (!socket.connected) socket.connect();
    socket.on('connect', (data) {});

    Map<String, dynamic> map = {
      "restaurant_id": restaurantId,
      "table": tableId,
      "user": userAccount.id,
    };

    socket.emit('open_tab', map);
    socket.on('tab_opened', (val) async {
      print(val);
      _restaurantID = restaurantId;
      _tableID = tableId;
      _userAccount = userAccount;
      _tabID = val['data']['_id'];
      userAccount.tab = TabModel(
        id: val['data']['_id'],
        attributes: TabModelAttributes(
          createdAt: val['data']['createdAt'],
          id: val['data']['_id'],
          tableId: val['data']['table'],
          restaurantId: val['data']['restaurant_id'],
          updatedAt: val['data']['updatedAt'],
          user: userAccount,
          groupCode: val['data']['group_code'].toString(),
          opened: val['data']['isOpen'],
        ),
      );
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(
        'tab',
        jsonEncode(val),
      );
      Functions().scaleToReplace(
        context,
        ScanSuccessful(userAccount: userAccount),
        removePreviousRoots: true,
      );
    });
    socket.on('open_tab_error', (val) {
      // print(val);
      Navigator.pop(context);
    });
  }

  closeTab(String tabID, BuildContext context) {
    _userAccount.tab = null;
    // socket.connect();
    // socket.on('connect', (data) => print(data));

    Map<String, dynamic> map = {
      "id": tabID,
    };

    socket.emit('close_tab', map);

    listenCloseTab(context);

    socket.on('tab_close_error', (val) {
      // print(val);
    });
  }

  listenCloseTab(BuildContext context) {
    socket.on('tab_closed', (val) async {
      print(val);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.remove(
        'tab',
      );

      // Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  getUserTab(
    UserAccount userAccount,
    BuildContext context,
  ) {
    if (!socket.connected) socket.connect();
    socket.on('connect', (data) {});

    setUser(userAccount);

    Map<String, dynamic> map = {
      "restaurant": _userAccount.tab.attributes.restaurantId,
      "tab": _userAccount.tab.id,
      "user": _userAccount.id,
    };

    if (_userAccount.tab != null) socket.emit('get_user_tab', map);
    socket.on('user_tab', (val) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Functions().scaleTo(
        context,
        MyTab(
          userAccount: userAccount,
          userTab: val['tabs'].isEmpty ? [] : val['tabs'][0]['orders'],
        ),
      );
      // _userTab = val['tabs']['orders'];
      notifyListeners();
    });
    socket.on('tabs_error', (val) {
      Functions().scaleTo(
        context,
        MyTab(
          userAccount: userAccount,
          userTab: [],
        ),
      );
      // print(val);
      // return val;
    });
  }

  requestWaiter(String tableID) {
    socket.connect();
    socket.on('connect', (data) => print(data));

    Map<String, dynamic> map = {"id": tableID};

    socket.emit('request_waiter', map);
    socket.on('waiter_requested', (val) {
      // print(val);
    });
    socket.on('request_waiter_error', (val) {
      // print(val);
    });
  }

  placeOrder(Map map) {
    socket.connect();
    socket.on('connect', (data) => print(data));

    // Map<String, dynamic> map = {"id": tableID};

    socket.emit('place_order', map);
    socket.on('order_placed', (val) {
      // print(val);
    });
    socket.on('place_order_error', (val) {
      // print(val);
    });
  }

  placeMultipleOrders(Map map) {
    socket.connect();
    socket.on('connect', (data) => print(data));

    // Map<String, dynamic> map = {"id": tableID};

    socket.emit('place_orders', map);
    socket.on('orders_placed', (val) {
      // print(val);
    });
    socket.on('place_orders_error', (val) {
      // print(val);
    });
  }

  String _tableID;
  String _restaurantID;
  UserAccount _userAccount;
  String _tabID;
  List _userTab;

  UserAccount get userAccount => _userAccount;

  List get userTab => _userTab;

  String get restaurantID => _restaurantID;

  String get tableID => _tableID;

  String get tab => _tabID;

  setUser(UserAccount userAccount) {
    _userAccount = userAccount;
    if (userAccount.tab != null) {
      _tableID = userAccount.tab.attributes.tableId;
      _restaurantID = userAccount.tab.attributes.restaurantId;
      _tabID = userAccount.tab.id;
    }

    // notifyListeners();
  }
}
