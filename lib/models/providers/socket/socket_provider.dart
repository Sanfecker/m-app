import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketProvider extends ChangeNotifier {
  static final String baseUrl = 'https://nulve-node-api.herokuapp.com/api/v1';

  IO.Socket socket = IO.io(baseUrl, <String, dynamic>{
    'transports': ['websocket'],
  });

  openTab(String restaurantId, tableId, userId) {
    socket.connect();
    socket.on('connect', (data) => print(data));

    Map<String, dynamic> map = {
      "restaurant_id": restaurantId,
      "table": tableId,
      "user": userId,
    };

    socket.emit('open_tab', map);
    socket.on('opened_tab', (val) {
      print(val);
      _restaurantID = restaurantId;
      _tableID = tableId;
      _userID = userId;
      _tabID = val['data']['_id'];
    });
    socket.on('open_tab_error', (val) {
      print(val);
    });
  }

  closeTab(String tabID) {
    socket.connect();
    socket.on('connect', (data) => print(data));

    Map<String, dynamic> map = {
      "id": tabID,
    };

    socket.emit('close_tab', map);

    socket.on('tab_closed', (val) {
      print(val);
    });
    socket.on('tab_close_error', (val) {
      print(val);
    });
  }

  getUserTab(String tabID, String restaurantID, String userID) {
    print(tabID);
    print(userID);
    print(restaurantID);
    socket.connect();
    socket.on('connect', (data) => print('data'));

    Map<String, dynamic> map = {
      "restaurant": restaurantID,
      "tab": tabID,
      "user": userID,
    };

    socket.emit('get_user_tab', map);
    socket.on('user_tab', (val) {
      print(val);
      // return val;
    });
    socket.on('tabs_error', (val) {
      print(val);
      // return val;
    });
  }

  requestWaiter(String tableID) {
    socket.connect();
    socket.on('connect', (data) => print(data));

    Map<String, dynamic> map = {"id": tableID};

    socket.emit('request_waiter', map);
    socket.on('waiter_requested', (val) {
      print(val);
    });
    socket.on('request_waiter_error', (val) {
      print(val);
    });
  }

  placeOrder(Map map) {
    socket.connect();
    socket.on('connect', (data) => print(data));

    // Map<String, dynamic> map = {"id": tableID};

    socket.emit('place_order', map);
    socket.on('order_placed', (val) {
      print(val);
    });
    socket.on('place_order_error', (val) {
      print(val);
    });
  }

  placeMultipleOrders(Map map) {
    socket.connect();
    socket.on('connect', (data) => print(data));

    // Map<String, dynamic> map = {"id": tableID};

    socket.emit('place_orders', map);
    socket.on('orders_placed', (val) {
      print(val);
    });
    socket.on('place_orders_error', (val) {
      print(val);
    });
  }

  String _tableID;
  String _restaurantID;
  String _userID;
  String _tabID;

  String get userID => _userID;

  String get restaurantID => _restaurantID;

  String get tableID => _tableID;

  String get tab => _tabID;

  setTab(String tableID, String restaurantID, String userID) {
    _tableID = tableID;
    _restaurantID = restaurantID;
    _userID = userID;
    notifyListeners();
  }
}
