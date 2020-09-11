import 'package:flutter/material.dart';
import 'package:Nuvle/components/widgets/user/callWaiterBottomSheet.dart';
import 'package:Nuvle/components/widgets/user/searchBottomSheet.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/styles/colors.dart';

class SearchIcon extends StatelessWidget {
  final UserAccount userAccount;

  const SearchIcon({Key key, this.userAccount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        size: 25,
        color: CustomColors.primary100,
      ),
      onPressed: () => Functions.openBottomSheet(
          context,
          SearchBottomSheet(
            userAccount: userAccount,
          ),
          true),
    );
  }
}
