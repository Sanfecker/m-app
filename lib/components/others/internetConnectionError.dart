import 'package:flutter/material.dart';
import 'package:nuvlemobile/styles/colors.dart';

class InternetConnectionError extends StatelessWidget { 
  final void Function() refreshCallBack;
  InternetConnectionError({@required this.refreshCallBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.error,
            color: CustomColors.primary100,
            size: 50,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 14),
            child: Text(
              "There is a problem with your internet connection. \n\nPlease try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: refreshCallBack,
              color: CustomColors.primary100,
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "REFRESH",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  letterSpacing: 0.875,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
