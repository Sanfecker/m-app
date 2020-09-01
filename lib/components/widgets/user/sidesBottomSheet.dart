import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/widgets/user/selectableListingWidget.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/menus/menuData.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:provider/provider.dart';

class SidesBottomSheet extends StatefulWidget {
  final MenuItems menuItem;
  final UserAccount userAccount;

  const SidesBottomSheet(
      {Key key, @required this.menuItem, @required this.userAccount})
      : super(key: key);

  @override
  _SidesBottomSheetState createState() => _SidesBottomSheetState();
}

class _SidesBottomSheetState extends State<SidesBottomSheet> {
  _handleSubmitted(BuildContext context) {
    // Provider.of<OrderProvider>(context, listen: false)
    //     .confirmedSideSelection(menuItem);
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Functions().customButton(context,
          onTap: () => _handleSubmitted(context),
          width: screenSize.width,
          text: "Add Side",
          specificBorderRadius: BorderRadius.zero),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sides",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Color(0xffF2F2F9),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 30,
                      color: CustomColors.primary100,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.menuItem.sides
                        .map(
                          (e) => SelectableListingWidget(
                              menuItem: e,
                              parent: widget.menuItem,
                              userAccount: widget.userAccount),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
