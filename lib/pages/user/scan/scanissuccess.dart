import 'package:flutter/material.dart';
import 'package:Nuvle/models/providers/mainPageProvider.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/styles/colors.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/pages/user/main/mainPage.dart';
import 'package:Nuvle/models/skeltons/user/tab.dart';

class ScanSuccessful extends StatefulWidget {
  final UserAccount userAccount;

  const ScanSuccessful({Key key, @required this.userAccount}) : super(key: key);
  @override
  _ScanSuccessfulState createState() => _ScanSuccessfulState();
}

class _ScanSuccessfulState extends State<ScanSuccessful> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabModel myTab = TabModel();

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    return new Timer(Duration(seconds: 2), () {
      Functions().scaleToReplace(
        context,
        MainPage(userAccount: widget.userAccount),
        removePreviousRoots: true,
      );
      MainPageProvider().selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              // margin: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: screenSize.width * 0.60,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Scan",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30)),
                        Text("Successful",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    // width: screenSize.width * 0.80,
                    margin: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Welcome enjoy your menu experience.",
                      style: TextStyle(
                        color: Color(0xffF2F2F9),
                        letterSpacing: 1,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 150,
              width: screenSize.width,
              child: Lottie.asset(
                'assets/json/lf20_OcSwPS.json',
                height: 246,
                width: 246,
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: Text(
                "Your Group Code",
                style: TextStyle(
                  color: Color(0xffF2F2F9),
                  letterSpacing: 1,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                "${widget.userAccount.tab.attributes.groupCode}",
                style: TextStyle(
                  color: CustomColors.primary,
                  letterSpacing: 1,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: Text(
                "Share this with anyone you'd like to join your tab",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffF2F2F9),
                  letterSpacing: 1,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
