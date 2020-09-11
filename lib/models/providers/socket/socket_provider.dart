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

  void connect() {
    if (!socket.connected) {
      socket.connect();
      print('connecting...');
    } else if (socket.connected) {
      socket.emit(
        'open_tab',
      );
    }
    socket.on('connect', (data) {
      socket.emit('open_tab');
    });
    // socket.on("connect", (data) => print('connected'));
    // socket.emit('init');
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

  void createTab(String tableID, String restaurantID, String userID) {
    connect();
    Map<String, dynamic> map = {
      "restaurant_id": restaurantID,
      "table": tableID,
      "user": userID,
    };
    _tableID = tableID;
    _restaurantID = restaurantID;
    _userID = userID;

    socket.on('connect', (data) {
      socket.emit('open_tab', map);
      socket.on('tab_opened', (data) {
        print(data);
      });
      socket.on('open_tab_error', (data) {
        print(data);
      });
    });
  }

  // getUserTab() {
  //   if (!socket.connected) {
  //     connect();
  //   }

  //   socket.on('connect', (data) {
  //     print('connected');
  //     String map =
  //         '{"restaurant": "$_restaurantID", "tab": "$_tableID", "user": "$_userID"}';
  //     print(jsonDecode(map));

  //     socket.emit('get_user_tab', jsonDecode(map));
  //     socket.on('user_tab', (data) {
  //       print('sata');
  //       print(data);
  //     });
  //     socket.on('tabs_error', (data) {
  //       print('sata');
  //       print(data);
  //     });
  //   });
  // }

  void callWaiter() {
    print(_tableID);
    connect();
    String map = '{"id": "$_tableID"}';
    // _tableID = tableID;
    // socket.connect();
    notifyListeners();
    // socket.on('connect', (data) => print('$data: connected'));

    socket.on('connect', (data) {
      print('connected');
      print('requesting');
      socket.emit("request_waiter", jsonDecode(map));
      socket.on('Waiter Requested', (data) {
        print(jsonEncode(data));
        print('waiter called');
      });
      socket.on('request_waiter_error', (data) {
        print(jsonEncode(data));
      });
    });

    notifyListeners();
  }

  // void closeTab() {
  //   Map<String, dynamic> map = {
  //     "restaurant_id": _restaurantID,
  //   };

  //   socket.emit('close_tab', map);
  //   notifyListeners();
  //   print('close');
  // }

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
