import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Nuvle/components/inputs/pinInputBox.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/pages/auth/login/loginEmail.dart';
import 'package:Nuvle/pages/auth/password/choosePassword.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';

class ResetCode extends StatefulWidget {
  final UserAccount userAccount;

  const ResetCode({Key key, this.userAccount}) : super(key: key);
  @override
  _ResetCodeState createState() => _ResetCodeState();
}

class _ResetCodeState extends State<ResetCode> {
  _handleSubmitted(BuildContext context) async {
    // Functions().transitTo(
    //   context,
    //   LoginPassowordPage(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 120),
                child: Container(
                  width: screenSize.width * 0.60,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Reset code",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              Text(
                "Just to be sure it is you, please enter the 6-digit code sent to your registered email address or phone number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 80),
              PinInput(
                autofocus: true,
                maxLength: 6,
                highlight: true,
                highlightColor: CustomColors.primary,
                pinBoxWidth: 40,
                defaultBorderColor:
                    Theme.of(context).primaryColor.withOpacity(0.6),
                hasTextBorderColor: CustomColors.primary,
                hasError: false,
                wrapAlignment: WrapAlignment.center,
                onDone: (text) => Functions().navigateTo(
                    context, ChoosePassword(userAccount: widget.userAccount)),
                pinBoxDecoration:
                    ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                pinTextStyle: TextStyle(fontSize: 24),
                pinTextAnimatedSwitcherTransition:
                    ProvidedPinBoxTextAnimation.scalingTransition,
                pinTextAnimatedSwitcherDuration: Duration(milliseconds: 100),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
