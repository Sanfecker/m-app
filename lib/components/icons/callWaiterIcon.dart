import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/widgets/user/callWaiterBottomSheet.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/socket_.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

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
      onPressed: () => Functions.openBottomSheet(
          context,
          CallWaiterBottomSheet(
            userAccount: userAccount,
          ),
          true),
      //     Functions().navigateTo(
      //   context,
      //   SocketCon(userAccount: userAccount),
      // ),
    );
  }
}
