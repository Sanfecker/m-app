import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/misc/settings.dart';
import 'package:Nuvle/models/providers/user/order/orderProvider.dart';
import 'package:Nuvle/models/skeltons/menus/menuData.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/pages/user/main/menus/itemInfo.dart';
import 'package:Nuvle/pages/user/main/menus/orderNow.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';
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
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: menuItem.imageUrl ?? '',
                      width: 109,
                      // height: 125,
                      height: 110,
                      errorWidget: (context, url, error) => Image.asset(
                        Settings.placeholderImageSmall,
                        width: 109,
                        height: 125,
                      ),
                      placeholder: (BuildContext context, String val) {
                        return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(CustomColors.primary),));
                      },
                      fit: menuItem.itemType.toLowerCase() == 'drink'
                          ? BoxFit.contain
                          : BoxFit.cover,
                    ),
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
                                    OrderNow(
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
