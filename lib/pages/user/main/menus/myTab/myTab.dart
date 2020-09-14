import 'package:flutter/material.dart';
import 'package:Nuvle/components/widgets/user/myTab/closeTabBottomSheet.dart';
import 'package:Nuvle/components/widgets/user/myTab/myTabListingWidget.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/providers/socket/socket_provider.dart';
import 'package:Nuvle/models/providers/user/order/orderProvider.dart';
import 'package:Nuvle/models/skeltons/menus/item.dart';
import 'package:Nuvle/models/skeltons/menus/menuData.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/pages/user/main/menus/myTab/shareTab.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class MyTab extends StatefulWidget {
  final UserAccount userAccount;
  final List userTab;

  const MyTab({Key key, @required this.userAccount, @required this.userTab})
      : super(key: key);
  @override
  _MyTabState createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {
  List<MenuItems> _tab = List<MenuItems>();
  @override
  void initState() {
    _tab = widget.userTab
        .map(
          (e) => MenuItems(
            price: e['markAsFree']
                ? '0'
                : e['discount'] == null
                    ? e['item_id']['price']
                    : (int.parse(e['item_id']['price']) *
                            int.parse(e['discount']) /
                            100)
                        .toString(),
            itemName: e['item_id']['item_name'],
            imageUrl: e['item_id']['image_url'],
            currency: e['item_id']['currency'],
            itemType: e['item_id']['_cls'],
          ),
        )
        .toList();
    print(_tab.length);
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
          List<MenuItems> food = List<MenuItems>();
          food = _tab
              .where((element) =>
                  element.itemType.toLowerCase() == 'menuitem.maindish' ||
                  element.itemType.toLowerCase() == 'menuitem.sidedish')
              .toList();
          List<MenuItems> drink = List<MenuItems>();
          drink = _tab
              .where((element) =>
                  element.itemType.toLowerCase() == 'menuitem.drink')
              .toList();
          List<MenuItems> dessert = List<MenuItems>();
          dessert = _tab
              .where((element) =>
                  element.itemType.toLowerCase() == 'menuitem.dessert')
              .toList();
          return Container(
            height: double.infinity,
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
                      onPressed: () => Functions().transitTo(
                          context,
                          ShareTab(
                            userAccount: widget.userAccount,
                          )),
                    ),
                  ],
                ),
                if (_tab.isEmpty)
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
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            // height: 115,
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return food.length > 0
                                    ? MyTabListingWidget(
                                        menuItem: food[index],
                                      )
                                    : null;
                              },
                              itemCount: food.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
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
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            // height: 115,
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return drink.length > 0
                                    ? MyTabListingWidget(
                                        menuItem: drink[index],
                                      )
                                    : null;
                              },
                              itemCount: drink.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
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
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            // height: 115,
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return dessert.length > 0
                                    ? MyTabListingWidget(
                                        menuItem: dessert[index],
                                      )
                                    : null;
                              },
                              itemCount: dessert.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Functions().customButton(
                          context,
                          onTap: () {
                            Functions.openBottomSheet(
                                context,
                                CloseTabBottomSheet(
                                  tab: _tab,
                                  userAccount: widget.userAccount,
                                ),
                                true);
                            // SocketProvider socketProvider =
                            //     Provider.of<SocketProvider>(context,
                            //         listen: false);
                            // socketProvider.getUserTab();
                          },
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
