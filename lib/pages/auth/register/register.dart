import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/validations.dart';
import 'package:nuvlemobile/models/providers/user/userAccountProvider.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/homepage.dart';
import 'package:nuvlemobile/pages/user/scan/scanCode.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final UserAccount userAccount;

  const RegisterPage({Key key, this.userAccount}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Validations _validations = Validations();
  UserAccount _user = UserAccount(attributes: UserAccountAttributes());
  DateTime _pickedDate;

  bool _obscureText = true, _autoValidate = false;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  FocusNode _emailFN = FocusNode();
  FocusNode _fnameFN = FocusNode();
  FocusNode _lnameFN = FocusNode();
  FocusNode _passFN = FocusNode();

  @override
  void dispose() {
    _emailFN.dispose();
    _fnameFN.dispose();
    _lnameFN.dispose();
    _passFN.dispose();
    super.dispose();
  }

  _handleSubmitted(BuildContext ctx) async {
    Functions().showLoadingDialog(ctx);
    FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true;
      Navigator.pop(ctx);
      showInSnackBar('Please fix the errors in red before submitting.');
    } else if (_pickedDate == null) {
      Navigator.pop(ctx);
      showInSnackBar('Pick your Date of Birth.');
    } else {
      form.save();
      try {
        _user.attributes.birthDate = _pickedDate;
        ApiRequestModel apiRequestModel =
            await Provider.of<UserAccountProvider>(context, listen: false)
                .registerAccount(_user);
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
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Hi, ",
                              ),
                              TextSpan(
                                text: "there",
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
                      Text(
                        "You dont have an account yet, fill the form below to sign up",
                        style: TextStyle(
                          color: Color(0xffF2F2F9),
                          letterSpacing: 1,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                InputBox(
                  bottomMargin: 30,
                  labelText: "First Name",
                  hintText: "Enter your first name",
                  textInputType: TextInputType.text,
                  enableSuggestions: true,
                  textInputAction: TextInputAction.next,
                  validateFunction: _validations.validateName,
                  focusNode: _fnameFN,
                  nextFocusNode: _lnameFN,
                  onSaved: (String val) => _user.attributes.firstname = val,
                ),
                InputBox(
                  bottomMargin: 30,
                  labelText: "Last Name",
                  hintText: "Enter your last name",
                  textInputType: TextInputType.text,
                  enableSuggestions: true,
                  textInputAction: TextInputAction.next,
                  validateFunction: _validations.validateName,
                  focusNode: _lnameFN,
                  nextFocusNode: _emailFN,
                  onSaved: (String val) => _user.attributes.lastname = val,
                ),
                InputBox(
                  bottomMargin: 30,
                  labelText: "Email Address",
                  hintText: "Enter your email address",
                  textInputType: TextInputType.emailAddress,
                  focusNode: _emailFN,
                  nextFocusNode: _passFN,
                  initialValue: widget.userAccount?.attributes?.email,
                  textInputAction: TextInputAction.next,
                  submitAction: () => _handleSubmitted(context),
                  validateFunction: _validations.validateEmail,
                  onSaved: (String val) => _user.attributes.email = val,
                ),
                InputBox(
                  bottomMargin: 30,
                  labelText: "Password",
                  hintText: "Enter your password",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  submitAction: () => _handleSubmitted(context),
                  validateFunction: _validations.validatePassword,
                  obscureText: _obscureText,
                  onSaved: (String val) => _user.attributes.password = val,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Date of birth",
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 1,
                              color: Color(0xffA6A6A6),
                            ),
                          ),
                          FlatButton(
                            onPressed: _pickDateOfBirth,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _pickedDate == null
                                    ? "Select date of birth"
                                    : DateFormat("dd/MMM", "en_US")
                                        .format(_pickedDate),
                                style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 0.36,
                                  color: Color(0xffF2F2F9),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CustomColors.primary,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(top: 7),
                      child: Text(
                        "To allow restaurants give birthday treats",
                        style:
                            TextStyle(color: Color(0xffA6A6A6), fontSize: 12),
                      ),
                    ),
                  ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  _pickDateOfBirth() async {
    DateTime now = DateTime.now();
    try {
      DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _pickedDate ?? now,
        firstDate: DateTime(now.year - 100, now.month, now.day),
        lastDate: now,
      );
      if (pickedDate != null) {
        setState(() {
          _pickedDate =
              DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
        });
      }
    } catch (e) {}
  }
}
