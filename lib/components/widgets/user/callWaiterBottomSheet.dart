import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Nuvle/components/buttons/circledButtonWithArrow.dart';
import 'package:Nuvle/components/curves/curveWave.dart';
import 'package:Nuvle/components/painters/circlePainter.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/providers/socket/socket_provider.dart';
import 'package:Nuvle/models/skeltons/user/scanResponse.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CallWaiterBottomSheet extends StatefulWidget {
  final UserAccount userAccount;

  const CallWaiterBottomSheet({Key key, @required this.userAccount})
      : super(key: key);
  @override
  _CallWaiterBottomSheetState createState() => _CallWaiterBottomSheetState();
}

class _CallWaiterBottomSheetState extends State<CallWaiterBottomSheet>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                CustomColors.primary100,
                Color.lerp(CustomColors.primary100, Colors.black, .05)
              ],
            ),
          ),
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: const CurveWave(),
              ),
            ),
            child: Icon(
              NuvleIcons.party_1,
              size: 70,
              color: Color(0xff4A444A),
            ),
          ),
        ),
      ),
    );
  }

  // void onScan(BuildContext context) async {
  //   print('jude');
  //   String data =
  //       '{"table_id":"5f1444977cb553df21b320e9","restaurant_id":"5ef0a89b27322047f0f0ce71"}';
  //   Map<String, dynamic> responseBody = jsonDecode(data);
  //   if (responseBody.containsKey("table_id") &&
  //       responseBody.containsKey("restaurant_id")) {
  //     ScanResponse scanResponse = ScanResponse.fromJson(responseBody);
  //     SocketProvider provider =
  //         Provider.of<SocketProvider>(context, listen: false);

  //     // print(widget.userAccount.id);

  //     provider.connect();
  //     // provider.createTab(scanResponse.tableId, scanResponse.restaurantId,
  //     //     widget.userAccount.id);
  //     dynamic val = await provider.listenOpenTab();
  //     provider.listenOpenTabError();
  //     print('listening to tab');
  //     print(val);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 60),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: CustomColors.primary100,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onLongPress: () {
                        SocketProvider provider =
                            Provider.of<SocketProvider>(context, listen: false);
                        // provider.callWaiter();

                        provider.requestWaiter(
                            widget.userAccount.tab.attributes.tableId);
                      },
                      child: CustomPaint(
                        painter: CirclePainter(
                          _controller,
                          color: CustomColors.primary100,
                        ),
                        child: SizedBox(
                          width: 80 * 4.125,
                          height: 80 * 4.125,
                          child: _button(),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: screenSize.width * 0.60,
                      child: Text(
                        'Hold button for 3 seconds to call a waiter',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                    CircledButtonWithArrow(
                      onPressed: () async => launch("tel:+2348106741811"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
