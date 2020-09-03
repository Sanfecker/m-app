import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/settings.dart';
import 'package:nuvlemobile/models/providers/mainPageProvider.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/menus/myOrder.dart';
import 'package:nuvlemobile/pages/user/main/menus/orderComplete.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  final UserAccount userAccount;

  MainPage({Key key, @required this.userAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer2<MainPageProvider, OrderProvider>(
        builder: (context, pro, pro2, child) => pro2.showOrderList &&
                pro2.orders.length > 0
            ? Container(
                height: 76,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 12, right: 12),
                child: Container(
                  height: 40,
                  child: Row(
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
                      Expanded(
                        child: Consumer<OrderProvider>(
                          builder: (context, pro, child) => ListView(
                            controller: pro.scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: pro.orders
                                .map(
                                  (e) => Container(
                                    padding: EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl: e.imageUrl ?? '',
                                            width: 48,
                                            height: 48,
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
                                          top: 0,
                                          child: Container(
                                            alignment: Alignment.center,
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
                                                size: 12,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: FlatButton(
                          onPressed: () => Functions().transitTo(
                              context,
                              OrderPage(
                                userAccount: userAccount,
                              )),
                          child: Text(
                            "Order",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          shape: StadiumBorder(),
                          color: CustomColors.primary100,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff263238),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.only(
                  bottom: 16,
                  top: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: ObjectKey("bnv_0"),
                      onPressed: () => pro.selectedIndex = 0,
                      child: Icon(
                        pro.tabIcons[0],
                        size: 25,
                        color: pro.selectedIndex == 0
                            ? Colors.black
                            : Color(0xFF4C4B5E),
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
                        color: pro.selectedIndex > 0
                            ? Colors.black
                            : Color(0xFF4C4B5E),
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
      body: Consumer<MainPageProvider>(
        builder: (context, pro, child) =>
            pro.tabs(userAccount)[pro.selectedIndex],
      ),
    );
  }
}
