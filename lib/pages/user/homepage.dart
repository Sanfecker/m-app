import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuvlemobile/models/providers/homePageProvider.dart';
import 'package:nuvlemobile/pages/user/scan/scanCode.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/settings.dart';
import 'package:nuvlemobile/models/providers/mainPageProvider.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/styles/colors.dart';

import 'main/menus/orderComplete.dart';
import 'main/profile/profile.dart';

int _page = 0;

class HomePage extends StatefulWidget {
  final UserAccount userAccount;
  const HomePage({
    Key key,
    this.userAccount,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    print(widget.userAccount.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buttomenuSubmitted(BuildContext ctx) async {
      Functions().showLoadingDialog(ctx);
      OrderProvider orderProvider =
          Provider.of<OrderProvider>(ctx, listen: false);
      try {
        ApiRequestModel apiRequestModel = await orderProvider.order(
            widget.userAccount, ctx, orderProvider.orders);
        if (apiRequestModel.isSuccessful) {
          Navigator.pop(ctx);
          Functions()
              .transitTo(ctx, OrderComplete(), PageTransitionType.downToUp);
        } else {
          Navigator.pop(ctx);
          await Fluttertoast.showToast(
            msg: apiRequestModel.errorMessage,
          );
        }
      } catch (e) {
        Navigator.pop(ctx);
        await Fluttertoast.showToast(
          msg: "Internal Error",
        );
      }
    }

    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: Consumer2<HomePageProvider, OrderProvider>(
        builder: (context, pro, pro2, child) => Container(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(
                color: Color.fromRGBO(69, 69, 69, 0.79),
              ),
            ),
          ),
          padding: EdgeInsets.only(top: 12, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                heroTag: ObjectKey("bnv_0"),
                onPressed: () => pro.selectedIndex = 0,
                child: Icon(
                  pro.tabIcons[0],
                  size: 25,
                  color:
                      pro.selectedIndex == 0 ? Colors.black : Color(0xFF4C4B5E),
                ),
                backgroundColor: pro.selectedIndex == 0
                    ? CustomColors.primary100
                    : Colors.transparent,
                elevation: pro.selectedIndex == 0 ? 5 : 0,
              ),
              FloatingActionButton(
                heroTag: ObjectKey("bnv_1"),
                onPressed: () => pro.selectedIndex = 1,
                child: Icon(
                  pro.tabIcons[1],
                  size: 25,
                  color:
                      pro.selectedIndex > 0 ? Colors.black : Color(0xFF4C4B5E),
                ),
                backgroundColor: pro.selectedIndex > 0
                    ? CustomColors.primary100
                    : Colors.transparent,
                elevation: pro.selectedIndex > 0 ? 5 : 0,
              ),
            ],
          ),
        ),
      ),
      body: Consumer<HomePageProvider>(
        builder: (context, pro, child) =>
            pro.tabs(widget.userAccount, scaffoldKey)[pro.selectedIndex],
      ),
    );
  }
}
