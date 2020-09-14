import 'package:flutter/material.dart';
import 'package:Nuvle/components/widgets/user/callWaiterBottomSheet.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/socket_.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';

class CallWaiterIcon extends StatelessWidget {
  final UserAccount userAccount;

  const CallWaiterIcon({Key key, @required this.userAccount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        NuvleIcons.party_1,
        size: 25,
        color: CustomColors.primary100,
      ),
      onPressed: () {
        Functions.openBottomSheet(
          context,
          CallWaiterBottomSheet(
            userAccount: userAccount,
          ),
          true,
        );
      },
    );
  }
}
