import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart' as IOS;


class SocketProvider extends ChangeNotifier {
  static final String baseUrl = 'https://nulve-node-api.herokuapp.com/api/v1';

  IO.Socket socket = IO.io(baseUrl, <String, dynamic>{
    'transports': ['websocket'],
  });

  void connect() {
    socket.connect();
    socket.on("connect", (data) => print('connected'));
    // socket.emit('init');
  }

  void connect1() {
    IO.Socket socket1 = IOS.io(baseUrl);
    socket1.on('connect', (_) {
      print('connect');
      String map = '{"id": "$_tableID"}';
      socket1.emit(
        "/request_waiter",
        jsonDecode(map),
      );
      // socket.emit('msg', 'test');
    });
    socket1.on('request_waiter', (data) => print(data));
  }

  String _tableID;
  String _restaurantID;
  String _userID;
  String _tab;

  String get userID => _userID;
  String get restaurantID => _restaurantID;
  String get tableID => _tableID;
  String get tab => _tab;

  setTab(String tableID, String restaurantID, String userID) {
    _tableID = tableID;
    _restaurantID = restaurantID;
    _userID = userID;
    notifyListeners();
  }

  void createTab(String tableID, String restaurantID, String userID) {
    Map<String, dynamic> map = {
      "restaurant_id": restaurantID,
      "table": tableID,
      "user": userID,
    };
    _tableID = tableID;
    _restaurantID = restaurantID;
    _userID = userID;

    socket.emitWithAck('open_tab', map, ack: (data) {
      print(data);
    });
    notifyListeners();
    print('emitt');
  }

  void callWaiter() {
    print(_tableID);
    Map<String, dynamic> map = {
      "id": _tableID,
    };
    _tableID = tableID;
    socket.connect();
    notifyListeners();
    socket.on('connect', (data) => print('$data: connected'));

    socket.once('connect', (data) {
      print('connected');
      print('requesting');
      socket.emitWithAck("request_waiter", map, ack: (data) {
        print(data);
        if (data != null) {
          print('from server $data');
        } else {
          print("Null");
        }
        print('requested');
      });
    });

    notifyListeners();
    print('waiter called');
  }

  void connect2() async {
    final String baseUrl = 'https://nulve-node-api.herokuapp.com/api/v1';

    IO.Socket socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      // 'extraHeaders': {'foo': 'bar'} // optional
    });
    Map<String, dynamic> map = {"id": _tableID};
    socket.connect();
    socket.on('connect', (data) {
      socket.emitWithAck("request_waiter", map, ack: (data) {
        print(data);
        if (data != null) {
          print('from server $data');
        } else {
          print("Null");
        }
      });
    });
  }

  void closeTab() {
    Map<String, dynamic> map = {
      "restaurant_id": _restaurantID,
    };

    socket.emit('close_tab', map);
    notifyListeners();
    print('close');
  }

  void getTab() {
    Map<String, dynamic> map = {
      "restaurant_id": _restaurantID,
    };

    socket.emitWithAck('close_tab', map);
    notifyListeners();
    print('close');
  }

  dynamic listenOpenTab() {
    socket.on('tab_opened', (dynamic val) {
      print(val);
      return val;
    });
  }

  dynamic listenOpenTabError() {
    socket.on('open_tab_error', (dynamic val) {
      print(val);
      return val;
    });
  }

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }


  void _onReceiveChatMessage(dynamic message) {
    print("Message from UFO: " + message);
  }


}
