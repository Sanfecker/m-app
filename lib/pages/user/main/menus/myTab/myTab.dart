import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/widgets/user/myTab/closeTabBottomSheet.dart';
import 'package:nuvlemobile/components/widgets/user/myTab/myTabListingWidget.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/menus/item.dart';
import 'package:nuvlemobile/models/skeltons/menus/menuData.dart';
import 'package:nuvlemobile/pages/user/main/menus/myTab/shareTab.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class MyTab extends StatefulWidget {
  @override
  _MyTabState createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {
  List<MenuItems> food = List<MenuItems>();
  List<MenuItems> drinks = List<MenuItems>();
  List<MenuItems> dessert = List<MenuItems>();
  OrderProvider _orderProvider;
  @override
  void initState() {
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    if (_orderProvider.tab.length > 0) {
      for (var e in _orderProvider.tab) {
        print(e.itemType);
        if (e.itemType.toLowerCase() == 'main dish') {
          food.add(e);
        } else if (e.itemType.toLowerCase() == 'drink') {
          drinks.add(e);
        } else if (e.itemType.toLowerCase() == 'dessert') {
          dessert.add(e);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Consumer<OrderProvider>(
        builder: (context, pro, child) {
          return Container(
            height: 730.8,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "My Tab",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xffF2F2F9),
                      ),
                    ),
                    FlatButton(
                      color: Color(0xffCFB06F),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "Share Tab",
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.3,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      shape: StadiumBorder(),
                      onPressed: () =>
                          Functions().transitTo(context, ShareTab()),
                    ),
                  ],
                ),
                if (pro.tab.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/illustration page 36.png",
                            height: 140,
                            width: 168,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'No Orders Yet',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Text(
                          "Food",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xffF2F2F9),
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 15),
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            // height: 115,
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: food
                                  .map(
                                    (i) => MyTabListingWidget(menuItem: i),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Drinks",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xffF2F2F9),
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 15),
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            // height: 115,
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: drinks
                                  .map(
                                    (i) => MyTabListingWidget(menuItem: i),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Dessert",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xffF2F2F9),
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 15),
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            // height: 115,
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: dessert
                                  .map(
                                    (i) => MyTabListingWidget(menuItem: i),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Functions().customButton(
                          context,
                          onTap: () => Functions.openBottomSheet(
                              context,
                              CloseTabBottomSheet(
                                tab: pro.tab,
                              ),
                              true),
                          width: screenSize.width,
                          height: 70,
                          text: "Close Tab",
                          color: CustomColors.primary900,
                          specificBorderRadius: BorderRadius.circular(10),
                          hasIcon: true,
                          trailing: Icon(
                            NuvleIcons.icon_right,
                            color: Color(0xff474551),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
