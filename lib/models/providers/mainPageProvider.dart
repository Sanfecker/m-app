import 'package:flutter/material.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/menus/menus.dart';
import 'package:nuvlemobile/pages/user/main/profile/profile.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class MainPageProvider extends ChangeNotifier {
  tabs(UserAccount userAccount) => [
        Menus(userAccount: userAccount),
        Profile(userAccount: userAccount),
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
