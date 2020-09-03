import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/settings.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/menus/menuData.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/menus/itemInfooo.dart';
import 'package:nuvlemobile/pages/user/main/menus/itemInfo.dart';
import 'package:nuvlemobile/pages/user/main/menus/orderItem.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class ListingWidget extends StatelessWidget {
  final MenuItems menuItem;
  final UserAccount userAccount;

  const ListingWidget(
      {Key key, @required this.userAccount, @required this.menuItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => Functions().scaleTo(
          context,
          ItemInfo(
            menuItem: menuItem,
            userAccount: userAccount,
          )),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: CachedNetworkImage(
                    imageUrl: menuItem.imageUrl ?? '',
                    width: 109,
                    height: 125,
                    // height: 110,
                    errorWidget: (context, url, error) => Image.asset(
                      Settings.placeholderImageSmall,
                      width: 109,
                      height: 125,
                    ),
                    placeholder: (BuildContext context, String val) {
                      return Image.asset(
                        Settings.placeholderImageSmall,
                        width: 109,
                        height: 125,
                      );
                    },
                    fit: BoxFit.contain,
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          if (2 == 0)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Mother's day",
                                    style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 0.36,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    NuvleIcons.star_1,
                                    size: 16,
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff263238),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            )
                          else
                            SizedBox(width: 20),
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 40,
                              ),
                              Container(
                                width: 50,
                                height: 40,
                                child: Consumer<OrderProvider>(
                                    builder: (context, pro, child) {
                                  return FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    color: CustomColors.primary,
                                    onPressed: () {
                                      pro.showOrderList = true;
                                      pro.addOrder(menuItem);
                                    },
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        menuItem.itemName.toLowerCase(),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            Functions.getCurrencySymbol(menuItem.currency) +
                                menuItem.price,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 38,
                              ),
                              Container(
                                width: 109,
                                height: 38,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  color: CustomColors.primary,
                                  onPressed: () => Functions().scaleTo(
                                    context,
                                    OrderItem(
                                        menuItem: menuItem,
                                        userAccount: userAccount),
                                  ),
                                  child: Text(
                                    "Order Now",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: CustomColors.licoRice,
            ),
          ),
        ),
      ),
    );
  }
}
