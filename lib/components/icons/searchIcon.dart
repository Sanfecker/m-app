import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/widgets/user/callWaiterBottomSheet.dart';
import 'package:nuvlemobile/components/widgets/user/searchBottomSheet.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/styles/colors.dart';

class SearchIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        size: 25,
        color: CustomColors.primary100,
      ),
      onPressed: () =>
          Functions.openBottomSheet(context, SearchBottomSheet(), true),
    );
  }
}
