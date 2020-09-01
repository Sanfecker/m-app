import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/homePageProvider.dart';
import 'package:nuvlemobile/models/providers/mainPageProvider.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/profile/profile.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class ProfileSettings extends StatefulWidget {
  final UserAccount userAccount;

  const ProfileSettings({Key key, @required this.userAccount})
      : super(key: key);
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool _obscureText = true, _obscureNewText = true;

  FocusNode _emailFN = FocusNode(),
      _oldPassFN = FocusNode(),
      _newPassFN = FocusNode();

  @override
  void dispose() {
    _emailFN.dispose();
    _oldPassFN.dispose();
    _newPassFN.dispose();
    super.dispose();
  }

  _handleSubmitted(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              page == 'home'
                  ? Consumer<HomePageProvider>(
                      builder: (context, pro, child) => Container(
                        margin: EdgeInsets.only(left: 20),
                        height: screenSize.height * 0.1,
                        child: GestureDetector(
                          onTap: () => pro.selectedIndex = 1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xFFD2B271),
                                size: 20,
                              ),
                              Text(
                                'Back',
                                style: TextStyle(
                                  color: Color(0xFFD2B271),
                                  fontSize: 14,
                                  letterSpacing: 1,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              FlatButton(
                                onPressed: () => print("Hey"),
                                child: Text(
                                  "Delete Account",
                                  style: TextStyle(
                                    color: CustomColors.primary,
                                    letterSpacing: 0.3,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Consumer<MainPageProvider>(
                      builder: (context, pro, child) => Container(
                        margin: EdgeInsets.only(left: 20),
                        height: screenSize.height * 0.1,
                        child: GestureDetector(
                          onTap: () => pro.selectedIndex = 1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xFFD2B271),
                                size: 20,
                              ),
                              Text(
                                'Back',
                                style: TextStyle(
                                  color: Color(0xFFD2B271),
                                  fontSize: 14,
                                  letterSpacing: 1,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              FlatButton(
                                onPressed: () => print("Hey"),
                                child: Text(
                                  "Delete Account",
                                  style: TextStyle(
                                    color: CustomColors.primary,
                                    letterSpacing: 0.3,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: screenSize.width * 0.60,
                margin: EdgeInsets.only(bottom: 60, top: 20),
                child: Text(
                  "Profile Settings",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Column(
                children: <Widget>[
                  InputBox(
                    bottomMargin: 30,
                    labelText: "Email Address",
                    hintText: "Enter your email address",
                    textInputType: TextInputType.emailAddress,
                    focusNode: _emailFN,
                    nextFocusNode: _oldPassFN,
                    textInputAction: TextInputAction.next,
                    initialValue: widget.userAccount.attributes.email,
                    onSaved: (String val) {},
                  ),
                  InputBox(
                    bottomMargin: 30,
                    labelText: "Enter old Password",
                    hintText: "Please enter your old password",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    obscureText: _obscureText,
                    focusNode: _oldPassFN,
                    nextFocusNode: _newPassFN,
                    onSaved: (String val) {},
                    suffix: Container(
                      margin: EdgeInsets.only(bottom: 4),
                      child: IconButton(
                        onPressed: () => setState(
                          () => _obscureText = !_obscureText,
                        ),
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey[500],
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  InputBox(
                    bottomMargin: 30,
                    labelText: "Enter new Password",
                    hintText: "Please enter your new password",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    submitAction: () => _handleSubmitted(context),
                    obscureText: _obscureNewText,
                    focusNode: _newPassFN,
                    onSaved: (String val) {},
                    suffix: Container(
                      margin: EdgeInsets.only(bottom: 4),
                      child: IconButton(
                        onPressed: () => setState(
                          () => _obscureNewText = !_obscureNewText,
                        ),
                        icon: Icon(
                          _obscureNewText
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                      text: "Save Changes",
                      hasIcon: true,
                      trailing: Icon(
                        NuvleIcons.icon_right,
                        color: Color(0xff474551),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
