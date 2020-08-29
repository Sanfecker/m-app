import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class OrderComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenSize.width * 0.70,
                margin: EdgeInsets.only(bottom: 10, top: 20),
                child: Text(
                  "Order Successfully Placed",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Lottie.asset('assets/json/lf20_qX4zwY.json'),
              Container(
                width: screenSize.width * 0.50,
                margin: EdgeInsets.only(top: 40),
                child: Text(
                  'Kindly hold on while we process your order',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, letterSpacing: 0.3),
                ),
              ),
              SizedBox(height: 120),
              Functions().customButton(
                context,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                width: screenSize.width,
                text: "Okay",
                color: CustomColors.primary900,
                hasIcon: true,
                trailing: Icon(
                  NuvleIcons.icon_checkmark,
                  color: Color(0xff474551),
                  size: 14,
                ),
              ),
              // Image.asset("assets/gifs/animation_500_kd5li9qp.gif")
            ],
          ),
        ),
      ),
    );
  }
}
