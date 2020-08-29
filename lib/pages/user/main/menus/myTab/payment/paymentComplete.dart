import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/pages/user/main/menus/myTab/feedback/ordersFeedback.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class PaymentComplete extends StatelessWidget {
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
              SizedBox(height: 60),
              Lottie.asset('assets/json/lf20_7W0ppe.json'),
              Container(
                width: screenSize.width * 0.70,
                margin: EdgeInsets.only(bottom: 10, top: 50),
                child: Column(
                  children: <Widget>[
                    Text(
                      "We hope you enjoyed your meal",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Please spare a moment to give us feedback on your experience.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, letterSpacing: 0.3),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 150),
              Functions().customButton(
                context,
                onTap: () {
                  Functions().transitToReplace(context, OrdersFeedback());
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
            ],
          ),
        ),
      ),
    );
  }
}
