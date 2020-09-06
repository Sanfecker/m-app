import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/auth/login/loginEmail.dart';
import 'package:nuvlemobile/pages/user/main/mainPage.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class ChoosePassword extends StatefulWidget {
  final UserAccount userAccount;

  const ChoosePassword({Key key, this.userAccount}) : super(key: key);
  @override
  _ChoosePasswordState createState() => _ChoosePasswordState();
}

class _ChoosePasswordState extends State<ChoosePassword> {
  bool _obscureText = true;

  _handleSubmitted(BuildContext context) async {
    Functions().transitTo(
      context,
      MainPage(
        userAccount: widget.userAccount,
      ),
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
                    "Choose new password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              InputBox(
                bottomMargin: 20,
                labelText: "Password",
                hintText: "Type your password",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                submitAction: () => _handleSubmitted(context),
                obscureText: _obscureText,
                onSaved: (String val) {},
                suffix: Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: IconButton(
                    onPressed: () => setState(
                      () => _obscureText = !_obscureText,
                    ),
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey[500],
                      size: 22,
                    ),
                  ),
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
