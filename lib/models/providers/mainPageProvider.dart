import 'package:flutter/material.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/pages/user/main/menus/menus.dart';
import 'package:Nuvle/pages/user/main/profile/changeDp.dart';
import 'package:Nuvle/pages/user/main/profile/contactSupport.dart';
import 'package:Nuvle/pages/user/main/profile/orderHistory.dart';
import 'package:Nuvle/pages/user/main/profile/paymentMethods.dart';
import 'package:Nuvle/pages/user/main/profile/profile.dart';
import 'package:Nuvle/pages/user/main/profile/profileSettings.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';

class MainPageProvider extends ChangeNotifier {
  tabs(UserAccount userAccount) => [
        Menus(userAccount: userAccount),
        Profile(userAccount: userAccount),
        ChangeDisplayPicture(),
        ProfileSettings(
          userAccount: userAccount,
        ),
        OrderHistory(
          userAccount: userAccount,
        ),
        PaymentMethods(),
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
