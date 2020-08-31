import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/inputs/cupertinoSwitchTile.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/user/userAccountProvider.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/profile/changeDp.dart';
import 'package:nuvlemobile/pages/user/main/profile/contactSupport.dart';
import 'package:nuvlemobile/pages/user/main/profile/orderHistory.dart';
import 'package:nuvlemobile/pages/user/main/profile/profileSettings.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final UserAccount userAccount;

  const Profile({Key key, @required this.userAccount}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _enableNotifications = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: () =>
                  Provider.of<UserAccountProvider>(context, listen: false)
                      .logoutCurrentUser(context),
              child: Text(
                "Log out",
                style: TextStyle(
                    color: CustomColors.primary,
                    letterSpacing: 0.3,
                    fontSize: 16),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 147,
                        width: 147,
                        child: Image.asset(
                          "assets/images/girl.png",
                        ),
                        decoration: BoxDecoration(shape: BoxShape.circle),
                      ),
                      Positioned(
                        child: IconButton(
                          onPressed: () => Functions()
                              .transitTo(context, ChangeDisplayPicture()),
                          icon: Icon(
                            NuvleIcons.icon,
                          ),
                        ),
                        bottom: -10,
                        right: -14,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.userAccount.attributes.firstname +
                        " " +
                        widget.userAccount.attributes.lastname,
                    style: TextStyle(
                      color: CustomColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 40),
                  Column(
                    children: List<Widget>.from(
                      ListTile.divideTiles(
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 20),
                            onTap: () => Functions().transitTo(
                                context,
                                ProfileSettings(
                                    userAccount: widget.userAccount)),
                            leading: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Icon(
                                NuvleIcons.icon__1_,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              "Edit Profile",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "Edit your profile settings",
                                style: TextStyle(
                                  color: Color(0xffA6A6A6),
                                ),
                              ),
                            ),
                            trailing: Container(
                              margin: EdgeInsets.only(right: 25),
                              child: Icon(
                                NuvleIcons.icon_right,
                                color: Color(0xffC7C7D4),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 20),
                            onTap: () => Functions().transitTo(context,
                                OrderHistory(userAccount: widget.userAccount)),
                            leading: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Icon(
                                NuvleIcons.icon__2_,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              "History",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "See your last meals",
                                style: TextStyle(
                                  color: Color(0xffA6A6A6),
                                ),
                              ),
                            ),
                            trailing: Container(
                              margin: EdgeInsets.only(right: 25),
                              child: Icon(
                                NuvleIcons.icon_right,
                                color: Color(0xffC7C7D4),
                              ),
                            ),
                          ),
                          CupertinoSwitchListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 20),
                            value: _enableNotifications,
                            onChanged: (val) =>
                                setState(() => _enableNotifications = val),
                            secondary: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Icon(
                                NuvleIcons.icon__3_,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              "Notifications",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "Notifications are enabled",
                                style: TextStyle(
                                  color: Color(0xffA6A6A6),
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 20),
                            onTap: () => print("Hey"),
                            leading: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Icon(
                                NuvleIcons.icon_credit_cart,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                            title: Text(
                              "Payment Method",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "Your payment method",
                                style: TextStyle(
                                  color: Color(0xffA6A6A6),
                                ),
                              ),
                            ),
                            trailing: Container(
                              margin: EdgeInsets.only(right: 25),
                              child: Icon(
                                NuvleIcons.icon_right,
                                color: Color(0xffC7C7D4),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 20),
                            onTap: () => Functions().transitTo(
                                context,
                                ContactSupport(
                                    userAccount: widget.userAccount)),
                            leading: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Icon(
                                NuvleIcons.icon__4_,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              "Support",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "Contact support",
                                style: TextStyle(
                                  color: Color(0xffA6A6A6),
                                ),
                              ),
                            ),
                            trailing: Container(
                              margin: EdgeInsets.only(right: 25),
                              child: Icon(
                                NuvleIcons.icon_right,
                                color: Color(0xffC7C7D4),
                              ),
                            ),
                          ),
                        ],
                        color: Colors.white,
                        context: context,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
