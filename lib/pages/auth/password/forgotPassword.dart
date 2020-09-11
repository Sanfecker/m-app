import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Nuvle/components/inputs/inputBox.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/pages/auth/login/loginEmail.dart';
import 'package:Nuvle/pages/auth/password/resetCode.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';

class ForgotPassword extends StatefulWidget {
  final UserAccount userAccount;

  const ForgotPassword({Key key, this.userAccount}) : super(key: key);
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  _handleSubmitted(BuildContext context) async {
    Functions().transitTo(
      context,
      ResetCode(),
    );
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
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 120),
                child: Container(
                  width: screenSize.width * 0.60,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Reset Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              InputBox(
                bottomMargin: 20,
                labelText: "Email Address",
                hintText: "Type your email address",
                initialValue: widget.userAccount?.attributes?.email,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                submitAction: () => _handleSubmitted(context), 
                onSaved: (String val) {},
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Functions().customButton(
                  context,
                  onTap: () => _handleSubmitted(context),
                  width: screenSize.width,
                  text: "Reset Password",
                  hasIcon: true,
                  trailing: Icon(
                    NuvleIcons.icon_right,
                    color: Color(0xff474551),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                color: Colors.transparent,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Remember password?  ",
                    children: [
                      TextSpan(
                        text: "Sign in",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffC0A368)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              Functions().transitTo(context, LoginEmailPage()),
                      ),
                    ],
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Color(0xffF2F2F9),
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          Functions().transitTo(context, LoginEmailPage()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
