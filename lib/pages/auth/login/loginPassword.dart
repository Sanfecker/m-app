import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/validations.dart';
import 'package:nuvlemobile/models/providers/user/userAccountProvider.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/auth/password/forgotPassword.dart';
import 'package:nuvlemobile/pages/auth/register/register.dart';
import 'package:nuvlemobile/pages/user/homepage.dart';
import 'package:nuvlemobile/pages/user/scan/scanCode.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class LoginPasswordPage extends StatefulWidget {
  final UserAccount userAccount;

  const LoginPasswordPage({Key key, @required this.userAccount})
      : super(key: key);

  @override
  _LoginPasswordPageState createState() => _LoginPasswordPageState();
}

class _LoginPasswordPageState extends State<LoginPasswordPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Validations _validations = Validations();

  bool _autoValidate = false, _obscureText = true;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  _handleSubmitted(BuildContext ctx) async {
    Functions().showLoadingDialog(ctx);
    FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true;
      Navigator.pop(ctx);
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      try {
        ApiRequestModel apiRequestModel =
            await Provider.of<UserAccountProvider>(context, listen: false)
                .loginAccount(widget.userAccount);
        if (apiRequestModel.isSuccessful) {
          Navigator.pop(ctx);
          Functions().scaleToReplace(
              context, HomePage(userAccount: apiRequestModel.result),
              removePreviousRoots: true);
        } else {
          Navigator.pop(ctx);
          showInSnackBar(apiRequestModel.errorMessage);
        }
      } catch (e) {
        Navigator.pop(ctx);
        showInSnackBar("Internal Error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  bottom: 100,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Hi, ",
                      ),
                      TextSpan(
                        text: widget.userAccount.attributes.firstname,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primary,
                        ),
                      ),
                    ],
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: InputBox(
                  bottomMargin: 20,
                  labelText: "Password",
                  hintText: "Type your password",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  submitAction: () => _handleSubmitted(context),
                  validateFunction: _validations.validatePassword,
                  obscureText: _obscureText,
                  onSaved: (String val) =>
                      widget.userAccount.attributes.password = val,
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
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Functions().customButton(
                  context,
                  onTap: () => _handleSubmitted(context),
                  width: screenSize.width,
                  text: "Login",
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
                    text: "Forgot password?  ",
                    children: [
                      TextSpan(
                        text: "Reset your password",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffC0A368)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Functions().transitTo(context,
                              ForgotPassword(userAccount: widget.userAccount)),
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
                      ..onTap = () => Functions().transitTo(context,
                          ForgotPassword(userAccount: widget.userAccount)),
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
