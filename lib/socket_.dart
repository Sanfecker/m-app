import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Nuvle/models/providers/socket/socket_provider.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'models/skeltons/user/scanResponse.dart';

class SocketCon extends StatefulWidget {
  final UserAccount userAccount;

  const SocketCon({Key key, @required this.userAccount}) : super(key: key);

  @override
  _SocketConState createState() => _SocketConState();
}

class _SocketConState extends State<SocketCon> {
  // @override
  // void initState() {
  //   super.initState();
  //   onScan(context);
  // }
  void onScan(BuildContext context) async {
    print('jude');
    String data =
        '{"table_id":"5f1444977cb553df21b320e9","restaurant_id":"5ef0a89b27322047f0f0ce71"}';
    Map<String, dynamic> responseBody = jsonDecode(data);
    if (responseBody.containsKey("table_id") &&
        responseBody.containsKey("restaurant_id")) {
      ScanResponse scanResponse = ScanResponse.fromJson(responseBody);
      SocketProvider provider =
          Provider.of<SocketProvider>(context, listen: false);

      print(widget.userAccount.id);

      connect();
      // provider.createTab(scanResponse.tableId, scanResponse.restaurantId,
      //     widget.userAccount.id);
      // dynamic val = await provider.listenOpenTab();
      // print('listening to tab');
      // print(val);
    }
  }

  void connect() async {
    final String baseUrl = 'https://nulve-node-api.herokuapp.com/api/v1';

    IO.Socket socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      // 'extraHeaders': {'foo': 'bar'} // optional
    });
    socket.connect();
    socket.on('connect', (data) => print(data));

    Map<String, dynamic> map = {
      "id": "5f5b3723aafe87001e861754",
    };

    socket.emit('close_tab', map);

    socket.on('tab_closed', (val) {
      print(val);
    });
    socket.on('tab_close_error', (val) {
      print(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: RaisedButton(
                onPressed: () => onScan(context),
                // onPressed: connect,
                child: Text('Connect'))));
  }
}
