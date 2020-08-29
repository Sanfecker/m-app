import 'package:flutter/material.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/menus/item.dart';
import 'package:nuvlemobile/pages/user/main/menus/itemInfo.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:provider/provider.dart';

class MyTabListingWidget extends StatelessWidget {
  final MenuItem menuItem;

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
                  child: Image.asset(
                    menuItem.img,
                    width: 112,
                    height: 109,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 13, right: 15),
                        child: Text(
                          menuItem.name.toLowerCase(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
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
                                child: Consumer<OrderProvider>(
                                  builder: (context, pro, child) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      // Container(
                                      //   width: 40,
                                      //   height: 40,
                                      //   child: FlatButton(
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.zero,
                                      //     ),
                                      //     color: CustomColors.primary,
                                      //     onPressed: () =>
                                      //         pro.changeOrderQuantity(
                                      //             menuItem, false),
                                      //     child: Text(
                                      //       "-",
                                      //       style: TextStyle(
                                      //         fontSize: 30,
                                      //         color: Colors.black,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Container(
                                      //   margin:
                                      //       EdgeInsets.symmetric(horizontal: 5),
                                      //   child: Text(
                                      //     pro
                                      //         .getSingleItem(menuItem)
                                      //         .orderQuantity
                                      //         .toString(),
                                      //     style: TextStyle(
                                      //       fontSize: 16,
                                      //       color: Colors.black,
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ),
                                      // Container(
                                      //   width: 45,
                                      //   height: 40,
                                      //   child: FlatButton(
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.zero,
                                      //     ),
                                      //     color: CustomColors.primary,
                                      //     onPressed: () =>
                                      //         pro.changeOrderQuantity(menuItem),
                                      //     child: Text(
                                      //       "+",
                                      //       style: TextStyle(
                                      //         fontSize: 30,
                                      //         color: Colors.black,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColors.primary,
                                ),
                              ),
                              // Container(
                              //   width: 109,
                              //   height: 38,
                              //   child: FlatButton(
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.zero,
                              //     ),
                              //     color: CustomColors.primary,
                              //     onPressed: () => print("Hey"),
                              //     child: Text(
                              //       "Order Now",
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
