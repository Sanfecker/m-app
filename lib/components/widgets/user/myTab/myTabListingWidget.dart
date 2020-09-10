import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/misc/settings.dart';
import 'package:Nuvle/models/providers/user/order/orderProvider.dart';
import 'package:Nuvle/models/skeltons/menus/item.dart';
import 'package:Nuvle/models/skeltons/menus/menuData.dart';
import 'package:Nuvle/pages/user/main/menus/itemInfooo.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:provider/provider.dart';

class MyTabListingWidget extends StatelessWidget {
  final MenuItems menuItem;

  const MyTabListingWidget({Key key, @required this.menuItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return InkResponse(
      // onTap: () => Functions().scaleTo(context, ItemInfo(menuItem: menuItem)),
      child: Container(
        margin: EdgeInsets.only(right: 20),
        width: screenSize.width > 600 ? 500 : screenSize.width * 0.85,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: CachedNetworkImage(
                    imageUrl: menuItem.imageUrl ?? '',
                    // width: 109,
                    // height: 125,
                    height: 110,
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
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 13, right: 15),
                        child: Text(
                          menuItem.itemName.toLowerCase(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              Functions.getCurrencySymbol(menuItem.currency) +
                                  menuItem.price,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xffd0b06f),
                              ),
                            ),
                            // Stack(
                            //   children: <Widget>[
                            //     Container(
                            //       height: 38,
                            //     ),
                            //     Container(
                            //       child: Consumer<OrderProvider>(
                            //         builder: (context, pro, child) => Row(
                            //           mainAxisAlignment: MainAxisAlignment.center,
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: <Widget>[
                            //             // Container(
                            //             //   width: 40,
                            //             //   height: 40,
                            //             //   child: FlatButton(
                            //             //     shape: RoundedRectangleBorder(
                            //             //       borderRadius: BorderRadius.zero,
                            //             //     ),
                            //             //     color: CustomColors.primary,
                            //             //     onPressed: () =>
                            //             //         pro.changeOrderQuantity(
                            //             //             menuItem, false),
                            //             //     child: Text(
                            //             //       "-",
                            //             //       style: TextStyle(
                            //             //         fontSize: 30,
                            //             //         color: Colors.black,
                            //             //       ),
                            //             //     ),
                            //             //   ),
                            //             // ),
                            //             // Container(
                            //             //   margin:
                            //             //       EdgeInsets.symmetric(horizontal: 5),
                            //             //   child: Text(
                            //             //     pro
                            //             //         .getSingleItem(menuItem)
                            //             //         .orderQuantity
                            //             //         .toString(),
                            //             //     style: TextStyle(
                            //             //       fontSize: 16,
                            //             //       color: Colors.black,
                            //             //       fontWeight: FontWeight.bold,
                            //             //     ),
                            //             //   ),
                            //             // ),
                            //             // Container(
                            //             //   width: 45,
                            //             //   height: 40,
                            //             //   child: FlatButton(
                            //             //     shape: RoundedRectangleBorder(
                            //             //       borderRadius: BorderRadius.zero,
                            //             //     ),
                            //             //     color: CustomColors.primary,
                            //             //     onPressed: () =>
                            //             //         pro.changeOrderQuantity(menuItem),
                            //             //     child: Text(
                            //             //       "+",
                            //             //       style: TextStyle(
                            //             //         fontSize: 30,
                            //             //         color: Colors.black,
                            //             //       ),
                            //             //     ),
                            //             //   ),
                            //             // ),
                            //           ],
                            //         ),
                            //       ),
                            //       decoration: BoxDecoration(
                            //         color: CustomColors.primary,
                            //       ),
                            //     ),
                            //     // Container(
                            //     //   width: 109,
                            //     //   height: 38,
                            //     //   child: FlatButton(
                            //     //     shape: RoundedRectangleBorder(
                            //     //       borderRadius: BorderRadius.zero,
                            //     //     ),
                            //     //     color: CustomColors.primary,
                            //     //     onPressed: () => print("Hey"),
                            //     //     child: Text(
                            //     //       "Order Now",
                            //     //       style: TextStyle(
                            //     //         fontSize: 14,
                            //     //         color: Colors.black,
                            //     //       ),
                            //     //     ),
                            //     //   ),
                            //     // ),
                            //   ],
                            // )
                          ],
                        ),
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
