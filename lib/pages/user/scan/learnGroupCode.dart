import 'package:flutter/material.dart';
import 'package:nuvlemobile/styles/colors.dart';

class LearnGroupCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/ilustration group code.png",
                          height: 313,
                          width: 313,
                        ),
                        SizedBox(height: 100),
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
                        SizedBox(height: 60),
                        Text(
                          "Scan the restaurant barcode and a group code will automatically be generated, allowing you to share your dining experience with others.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
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
