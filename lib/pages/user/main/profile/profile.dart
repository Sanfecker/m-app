import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Nuvle/components/inputs/cupertinoSwitchTile.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/providers/homePageProvider.dart';
import 'package:Nuvle/models/providers/mainPageProvider.dart';
import 'package:Nuvle/models/providers/user/userAccountProvider.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/pages/user/homepage.dart';
import 'package:Nuvle/pages/user/main/profile/changeDp.dart';
import 'package:Nuvle/pages/user/main/profile/contactSupport.dart';
import 'package:Nuvle/pages/user/main/profile/orderHistory.dart';
import 'package:Nuvle/pages/user/main/profile/profileSettings.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String page = 'home';

class Profile extends StatefulWidget {
  final UserAccount userAccount;

  const Profile({Key key, @required this.userAccount}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _enableNotifications = true;
  String profilePic;
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      profilePic = value.getString('dp');
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 724,
        child: Column(
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
            page == 'home'
                ? Consumer<HomePageProvider>(
                    builder: (context, pro, child) => SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                ClipOval(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    width: MediaQuery.of(context).size.height *
                                        0.18,
                                    child: profilePic != null
                                        ? Image.file(
                                            File(profilePic),
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(
                                            Icons.image,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.09,
                                          ),
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                  ),
                                ),
                                Positioned(
                                  child: IconButton(
                                    onPressed: () => pro.selectedIndex = 2,
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
                            // SizedBox(height: 30),
                            Column(
                              children: List<Widget>.from(
                                ListTile.divideTiles(
                                  tiles: [
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 20),
                                      onTap: () => pro.selectedIndex = 3,
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
                                          color: Color(0xfff2f2f9)
                                              .withOpacity(0.9),
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                      subtitle: Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Edit your profile settings",
                                          style: TextStyle(
                                            fontSize: 12,
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
                                      onTap: () => pro.selectedIndex = 4,
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
                                          color: Color(0xfff2f2f9)
                                              .withOpacity(0.9),
                                          letterSpacing: 0.3,
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
                                      onChanged: (val) => setState(
                                          () => _enableNotifications = val),
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
                                          color: Color(0xfff2f2f9)
                                              .withOpacity(0.9),
                                          letterSpacing: 0.3,
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
                                      onTap: () => pro.selectedIndex = 5,
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
                                          color: Color(0xfff2f2f9)
                                              .withOpacity(0.9),
                                          letterSpacing: 0.3,
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
                                      onTap: () => pro.selectedIndex = 6,
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
                                          color: Color(0xfff2f2f9)
                                              .withOpacity(0.9),
                                          letterSpacing: 0.3,
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
                                  color: Color(0xff4A444A),
                                  context: context,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Consumer<MainPageProvider>(
                    builder: (context, pro, child) => SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                ClipOval(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    width: MediaQuery.of(context).size.height *
                                        0.18,
                                    child: profilePic != null
                                        ? Image.file(
                                            File(profilePic),
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(
                                            Icons.image,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.09,
                                          ),
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                  ),
                                ),
                                Positioned(
                                  child: IconButton(
                                    onPressed: () => pro.selectedIndex = 2,
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
                            // SizedBox(height: 30),
                            Column(
                              children: List<Widget>.from(
                                ListTile.divideTiles(
                                  tiles: [
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 20),
                                      onTap: () => pro.selectedIndex = 3,
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
                                          color: Color(0xfff2f2f9)
                                              .withOpacity(0.9),
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                      subtitle: Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Edit your profile settings",
                                          style: TextStyle(
                                            fontSize: 12,
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
                                      onTap: () => pro.selectedIndex = 4,
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
                                          color: Color(0xfff2f2f9)
                                              .withOpacity(0.9),
                                          letterSpacing: 0.3,
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
                                      onChanged: (val) => setState(
                                          () => _enableNotifications = val),
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
                                          color: Color(0xfff2f2f9)
                                              .withOpacity(0.9),
                                          letterSpacing: 0.3,
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
                                      onTap: () => pro.selectedIndex = 5,
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
                                          color: Color(0xfff2f2f9)
                                              .withOpacity(0.9),
                                          letterSpacing: 0.3,
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
                                      onTap: () => pro.selectedIndex = 6,
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
                                          color: Color(0xfff2f2f9)
                                              .withOpacity(0.9),
                                          letterSpacing: 0.3,
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
                                  color: Color(0xff4A444A),
                                  context: context,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
