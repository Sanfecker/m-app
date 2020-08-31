import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/mainPage.dart';

class ScanSuccessfulPage extends StatefulWidget {
  final UserAccount userAccount;

  const ScanSuccessfulPage({Key key, @required this.userAccount})
      : super(key: key);
  @override
  _ScanSuccessfulPageState createState() => _ScanSuccessfulPageState();
}

class _ScanSuccessfulPageState extends State<ScanSuccessfulPage> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    return new Timer(
      Duration(seconds: 1),
      () => Functions().scaleToReplace(
          context, MainPage(userAccount: widget.userAccount),
          removePreviousRoots: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(),
            Lottie.asset(
              'assets/json/lf20_OcSwPS.json',
              height: 246,
              width: 246,
            ),
            Container(
              width: screenSize.width * 0.70,
              margin: EdgeInsets.only(top: 40),
              child: Text(
                'You\'ve successfully joined\n${widget.userAccount.tab.attributes.user.attributes.firstname}\'s Tab',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
