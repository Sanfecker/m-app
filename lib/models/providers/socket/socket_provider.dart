import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart' as IOS;
import 'package:web_socket_channel/status.dart' as status;

import 'package:web_socket_channel/io.dart';

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

  void callWaiter2() {
    final String baseUrl =
        'https://nulve-node-api.herokuapp.com/api/v1/request_waiter';
    final channel = IOWebSocketChannel.connect(baseUrl);

    channel.stream.listen((message) {
      channel.sink.add({'id': '5f07e5b364e680e03b9fc676'});
      print(message);
      channel.sink.close(status.goingAway);
    });
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

  SocketIO socketIO;
  connectSocket01() async {
    //update your domain before using
    socketIO = SocketIOManager().createSocketIO(baseUrl, "/request_waiter",
        query: "id=5f07e5b364e680e03b9fc676",
        socketStatusCallback: _socketStatus);

    //call init socket before doing anything
    await socketIO.init();

    //subscribe event
    // socketIO.subscribe("socket_info", _onSocketInfo);

    //connect socket
    await socketIO.connect();
    await socketIO.sendMessage('request_waiter', '{"id": "$_tableID"}');
    _subscribes();
  }

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

  _subscribes() {
    if (socketIO != null) {
      socketIO.subscribe("request_waiter", _onReceiveChatMessage);
    }
  }

  void _onReceiveChatMessage(dynamic message) {
    print("Message from UFO: " + message);
  }

  void _sendChatMessage(String msg) async {
    if (socketIO != null) {
      String jsonData =
          '{"message":{"type":"Text","content": ${(msg != null && msg.isNotEmpty) ? '"${msg}"' : '"Hello SOCKET IO PLUGIN :))"'},"owner":"589f10b9bbcd694aa570988d","avatar":"img/avatar-default.png"},"sender":{"userId":"589f10b9bbcd694aa570988d","first":"Ha","last":"Test 2","location":{"lat":10.792273999999999,"long":106.6430356,"accuracy":38,"regionId":null,"vendor":"gps","verticalAccuracy":null},"name":"Ha Test 2"},"receivers":["587e1147744c6260e2d3a4af"],"conversationId":"589f116612aa254aa4fef79f","name":null,"isAnonymous":null}';
      socketIO.sendMessage("chat_direct", jsonData, _onReceiveChatMessage);
    }
  }

  _destroySocket() {
    if (socketIO != null) {
      SocketIOManager().destroySocket(socketIO);
    }
  }
}
