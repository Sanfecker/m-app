import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/misc/settings.dart';
import 'package:Nuvle/models/skeltons/menus/item.dart';
import 'package:Nuvle/models/skeltons/menus/menuData.dart';
import 'package:Nuvle/pages/user/main/menus/itemInfooo.dart';
import 'package:Nuvle/styles/colors.dart';

class SearchResultListingWidget extends StatelessWidget {
  final MenuItems menuItem;

  const SearchResultListingWidget({Key key, @required this.menuItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      // onTap: () => Functions().scaleTo(context, ItemInfo(menuItem: menuItem)),
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Stack(
          alignment: Alignment.center,
          overflow: Overflow.visible,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      width: 109,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 13, right: 15),
                            child: Text(
                              menuItem.itemName.toLowerCase(),
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(height: 12),
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
                              Container(
                                width: 109,
                                height: 38,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  color: CustomColors.primary,
                                  onPressed: () => print("Hey"),
                                  child: Text(
                                    "Order Now",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
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
            Positioned(
              left: 15,
              child: CachedNetworkImage(
                imageUrl: menuItem.imageUrl ?? '',
                width: 109,
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
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
