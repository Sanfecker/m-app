import 'package:flutter/material.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/profile/changeDp.dart';
import 'package:nuvlemobile/pages/user/main/profile/contactSupport.dart';
import 'package:nuvlemobile/pages/user/main/profile/orderHistory.dart';
import 'package:nuvlemobile/pages/user/main/profile/profile.dart';
import 'package:nuvlemobile/pages/user/main/profile/profileSettings.dart';
import 'package:nuvlemobile/pages/user/scan/scanCode.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class HomePageProvider extends ChangeNotifier {
  tabs(UserAccount userAccount, GlobalKey<ScaffoldState> scaffoldKey) => [
        ScanCodePage(
          userAccount: userAccount,
          scaffoldKey: scaffoldKey,
        ),
        Profile(userAccount: userAccount),
        ChangeDisplayPicture(),
        ProfileSettings(
          userAccount: userAccount,
        ),
        OrderHistory(
          userAccount: userAccount,
        ),
        ContactSupport(
          userAccount: userAccount,
        ),
      ];
  List<IconData> get tabIcons => [
        NuvleIcons.group_121,
        NuvleIcons.group_122,
      ];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }
}
