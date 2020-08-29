import 'package:flutter/material.dart';
import 'package:nuvlemobile/models/skeltons/onBoarding/onBoardData.dart';
import 'package:nuvlemobile/styles/colors.dart';

class OnBoardingWidgetOne extends StatelessWidget {
  final OnBoardData onBoardData;

  const OnBoardingWidgetOne({Key key, @required this.onBoardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              onBoardData.img,
              height: 313,
              width: 313,
            ),
            SizedBox(height: 100),
            Text(
              onBoardData.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.primary),
            ),
            SizedBox(height: 30),
            Text(
              onBoardData.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
