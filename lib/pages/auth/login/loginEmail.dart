import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/validations.dart';
import 'package:nuvlemobile/models/providers/user/userAccountProvider.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/auth/login/loginPassword.dart';
import 'package:nuvlemobile/pages/auth/register/register.dart';
import 'package:nuvlemobile/pages/user/main/mainPage.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class LoginEmailPage extends StatefulWidget {
  @override
  _LoginEmailPageState createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Validations _validations = Validations();
  UserAccount _user = UserAccount(attributes: UserAccountAttributes());

  bool _autoValidate = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        Provider.of<UserAccountProvider>(context, listen: false)
            .setHasSeenOnBoard());
    super.initState();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  _handleSubmitted(BuildContext context) async { 
    Functions().showLoadingDialog(context);
    FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true;
      Navigator.pop(context);
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      try {
        ApiRequestModel apiRequestModel =
            await Provider.of<UserAccountProvider>(context, listen: false)
                .checkIfUserExists(_user);
        if (apiRequestModel.isSuccessful) {
          UserAccount account = apiRequestModel.result;
          account.attributes.email = _user.attributes.email;
          Navigator.pop(context);
          Functions().scaleTo(context, LoginPasswordPage(userAccount: account));
        } else {
          Navigator.pop(context);
          if (apiRequestModel.errorMessage.trim().toLowerCase() ==
              "Could not find any matching account".toLowerCase()) {
            Functions().scaleTo(context, RegisterPage(userAccount: _user));
          } else {
            showInSnackBar(apiRequestModel.errorMessage);
          }
        }
      } catch (e) {
        print(e);
        Navigator.pop(context);
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Hi There",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Text(
                      "Enter your email address to begin",
                      style: TextStyle(
                        color: Color(0xffF2F2F9),
                        letterSpacing: 1,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: InputBox(
                  bottomMargin: 20,
                  labelText: "Email Address",
                  hintText: "Type your email address",
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  submitAction: () => _handleSubmitted(context),
                  onSaved: (String val) => _user.attributes.email = val,
                  validateFunction: _validations.validateEmail,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Functions().customButton(
                  context,
                  onTap: () => _handleSubmitted(context),
                  width: screenSize.width,
                  text: "Continue",
                  hasIcon: true,
                  trailing: Icon(
                    NuvleIcons.icon_right,
                    color: Color(0xff474551),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "OR",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                            fontSize: 16,
                            color: Color(0xffD1B170)),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Sign in using your social",
                    style: TextStyle(
                      color: Color(0xffF2F2F9),
                      letterSpacing: 1,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => Functions().scaleTo(
                            context,
                            MainPage(
                              userAccount: UserAccount(),
                            )),
                        child: Image.asset("assets/images/Group (1).png"),
                      ),
                      SizedBox(width: 50),
                      FlatButton(
                        onPressed: () =>
                            Functions().scaleTo(context, RegisterPage()),
                        child: Image.asset("assets/images/Group.png"),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
