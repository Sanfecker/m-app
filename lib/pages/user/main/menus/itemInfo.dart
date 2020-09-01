import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/icons/callWaiterIcon.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/settings.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/menus/menuData.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/menus/orderItem.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class ItemInfo extends StatefulWidget {
  final UserAccount userAccount;
  final MenuItems menuItem;

  const ItemInfo({Key key, @required this.userAccount, @required this.menuItem})
      : super(key: key);

  @override
  _ItemInfoState createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  _handleSubmitted(BuildContext context) async {
    await Functions().transitTo(
      context,
      OrderItem(menuItem: widget.menuItem, userAccount: widget.userAccount),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          CallWaiterIcon(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: widget.menuItem.sides != null &&
                    widget.menuItem.sides.isNotEmpty
                ? MediaQuery.of(context).size.height * 0.9
                : MediaQuery.of(context).size.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2992,
                  child: Row(
                    mainAxisAlignment: widget.menuItem.itemTags.length > 0
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: widget.menuItem.itemTags
                            .map(
                              (e) => Container(
                                child: FlatButton(
                                  color: Color(0xff4A444A),
                                  child: Text(
                                    e.tagName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  shape: StadiumBorder(),
                                  onPressed: () => print("Hey"),
                                  height: 20,
                                  minWidth: 30,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      CachedNetworkImage(
                        imageUrl: widget.menuItem.imageUrl ?? '',
                        width: MediaQuery.of(context).size.width * 0.6,
                        filterQuality: FilterQuality.high,
                        errorWidget: (context, url, error) => Container(
                          child: Image.asset(
                            Settings.placeholderImageSmall,
                            width: 215,
                            height: 245,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                        placeholder: (BuildContext context, String val) {
                          return Container(
                            child: Image.asset(
                              Settings.placeholderImageSmall,
                              width: 215,
                              height: 245,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                          );
                        },
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            widget.menuItem.itemName.toLowerCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Text(
                        Functions.getCurrencySymbol(widget.menuItem.currency) +
                            widget.menuItem.price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color(0xffF2F2F9),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Description',
                  style: TextStyle(
                    color: Color(0xffD4B472),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  widget.menuItem.description,
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 40),
                if (widget.menuItem.sides != null &&
                    widget.menuItem.sides.isNotEmpty)
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommended Pairings',
                          style: TextStyle(
                            color: Color(0xffD4B472),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'These pair well with ${widget.menuItem.itemName}',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 12),
                        Expanded(
                          child: Container(
                            // height: 200,
                            child: LimitedBox(
                              // height: 30,
                              // color: Colors.green,
                              child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: widget.menuItem.sides.map((e) {
                                    return Container(
                                      // height: 83,
                                      // width: 120,
                                      margin: EdgeInsets.only(
                                        right: 20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Consumer<OrderProvider>(
                                              builder: (context, pro, child) =>
                                                  GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    widget.menuItem
                                                            .confirmedSides
                                                            .contains(e)
                                                        ? widget.menuItem
                                                            .confirmedSides
                                                            .remove(e)
                                                        : widget.menuItem
                                                            .confirmedSides
                                                            .add(e);
                                                  });
                                                  print(widget
                                                      .menuItem.confirmedSides
                                                      .contains(e));
                                                  print(widget.menuItem
                                                      .confirmedSides.length);
                                                  // menuItem.selectedSides
                                                  //     .removeRange(
                                                  //         0,
                                                  //         menuItem.selectedSides
                                                  //             .length);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color(0xFFD5B572),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  // padding: const EdgeInsets.all(
                                                  //   17,
                                                  // ),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              e.imageUrl ?? '',
                                                          width: 80,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Container(
                                                            child: Image.asset(
                                                              Settings
                                                                  .placeholderImageSmall,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .transparent,
                                                            ),
                                                          ),
                                                          placeholder:
                                                              (BuildContext
                                                                      context,
                                                                  String val) {
                                                            return Image.asset(
                                                              Settings
                                                                  .placeholderImageSmall,
                                                            );
                                                          },
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                      if (widget.menuItem
                                                          .confirmedSides
                                                          .contains(e))
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromRGBO(
                                                              229,
                                                              194,
                                                              122,
                                                              0.7,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height:
                                                              double.infinity,
                                                          width: 114,
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Color(
                                                                0xFF4C4B5E),
                                                            size: 30,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            e.itemName,
                                            softWrap: true,
                                            style: TextStyle(
                                              letterSpacing: 0.3,
                                              fontSize: 12,
                                              color: Color(0xFFF2F2F9),
                                            ),
                                          ),
                                          // Spacer(),
                                          Text(
                                            '${e.calorieCount} Kcal',
                                            style: TextStyle(
                                              letterSpacing: 0.3,
                                              fontSize: 10,
                                              color: Color(0xFFF2F2F9),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Functions().customButton(
                    context,
                    onTap: () => _handleSubmitted(context),
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: "Order",
                    color: CustomColors.primary900,
                    hasIcon: true,
                    trailing: Icon(
                      NuvleIcons.icon_right,
                      color: Color(0xff474551),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
