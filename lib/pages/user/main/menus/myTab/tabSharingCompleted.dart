import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TabSharingCompleted extends StatefulWidget {
  @override
  _TabSharingCompletedState createState() => _TabSharingCompletedState();
}

class _TabSharingCompletedState extends State<TabSharingCompleted> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    return new Timer(Duration(seconds: 1), () => Navigator.pop(context));
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
              width: screenSize.width * 0.80,
              margin: EdgeInsets.only(top: 40),
              child: Text(
                'Your Invite has being sent',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
