import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/widgets/user/callWaiterBottomSheet.dart';
import 'package:nuvlemobile/components/widgets/user/searchBottomSheet.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/styles/colors.dart';

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
