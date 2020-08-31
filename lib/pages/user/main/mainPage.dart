import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/settings.dart';
import 'package:nuvlemobile/models/providers/mainPageProvider.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/menus/orderComplete.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  final UserAccount userAccount;

  MainPage({Key key, @required this.userAccount}) : super(key: key);

  _handleSubmitted(BuildContext ctx) async {
    Functions().showLoadingDialog(ctx);
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(ctx, listen: false);
    try {
      ApiRequestModel apiRequestModel =
          await orderProvider.order(userAccount, orderProvider.orders);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer2<MainPageProvider, OrderProvider>(
        builder: (context, pro, pro2, child) => pro2.showOrderList &&
                pro2.orders.length > 0
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 30,
                        color: CustomColors.primary100,
                      ),
                      onPressed: () {
                        pro2.showOrderList = false;
                        pro2.orders.removeRange(0, pro2.orders.length);
                      },
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: 70,
                        margin: EdgeInsets.only(right: 10),
                        child: Consumer<OrderProvider>(
                          builder: (context, pro, child) => ListView(
                            controller: pro.scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: pro.orders
                                .map(
                                  (e) => Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl: e.imageUrl ?? '',
                                            width: 65,
                                            height: 63,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              Settings.placeholderImageSmall,
                                              width: 65,
                                              height: 63,
                                            ),
                                            placeholder: (BuildContext context,
                                                String val) {
                                              return Image.asset(
                                                Settings.placeholderImageSmall,
                                                width: 65,
                                                height: 63,
                                              );
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: -3,
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            child: FlatButton(
                                              color: CustomColors.primary100,
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              onPressed: () =>
                                                  pro.removeOrder(e),
                                              child: Icon(
                                                Icons.close,
                                                color: CustomColors.licoRice,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () => _handleSubmitted(context),
                      child: Text(
                        "Order",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      shape: StadiumBorder(),
                      color: CustomColors.primary100,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color(0xff263238),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    )),
              )
            : Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: pro.tabIcons.map((e) {
                    int i = pro.tabIcons.indexOf(e);
                    return i == pro.selectedIndex
                        ? FloatingActionButton(
                            heroTag: ObjectKey("bnv_$i"),
                            onPressed: () => pro.selectedIndex = i,
                            child: Icon(
                              e,
                              size: 20,
                            ),
                            backgroundColor: CustomColors.primary100,
                          )
                        : IconButton(
                            icon: Icon(
                              e,
                              color: Color(0xff828282),
                              size: 20,
                            ),
                            onPressed: () => pro.selectedIndex = i,
                          );
                  }).toList(),
                ),
              ),
      ),
      body: SafeArea(
        child: Consumer<MainPageProvider>(
          builder: (context, pro, child) =>
              pro.tabs(userAccount)[pro.selectedIndex],
        ),
      ),
    );
  }
}
