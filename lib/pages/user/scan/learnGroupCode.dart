import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/buttons/circledButtonWithArrow.dart';
import 'package:nuvlemobile/styles/colors.dart';

class LearnGroupCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
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
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/ilustration group code.png",
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.height * 0.4,
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Group Code",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Multi Dining Experience",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primary),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Multiple people, one tab. Entering someone’s group code allows you to join their tab meaning they will be picking up the bill at the end of the dining experience. If you would like to foot your own bill, please scan your table’s QR code and create a tab for yourself.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: CircledButtonWithArrow(onPressed: null),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
