import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/widgets/user/myTab/closeTabBottomSheet.dart';
import 'package:nuvlemobile/components/widgets/user/myTab/myTabListingWidget.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/skeltons/menus/item.dart';
import 'package:nuvlemobile/pages/user/main/menus/myTab/shareTab.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class MyTab extends StatefulWidget {
  @override
  _MyTabState createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      bottomNavigationBar: Functions().customButton(
        context,
        onTap: () =>
            Functions.openBottomSheet(context, CloseTabBottomSheet(), true),
        width: screenSize.width,
        height: 70,
        text: "Close Tab",
        color: CustomColors.primary900,
        specificBorderRadius: BorderRadius.zero,
        hasIcon: true,
        trailing: Icon(
          NuvleIcons.icon_right,
          color: Color(0xff474551),
        ),
      ),
      body: Padding(
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
                  onPressed: () => Functions().transitTo(context, ShareTab()),
                ),
              ],
            ),
            if (1 == 2)
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
              Flexible(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 50),
                        Text(
                          "Food",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xffF2F2F9),
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 115,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              10,
                              (i) => MyTabListingWidget(
                                menuItem: MenuItem(
                                  sId: "fo" + i.toString(),
                                  img:
                                      "assets/images/FAVPNG_barbecue-grill-beefsteak-beef-plate-grilling_PMai9z2w 2.png",
                                  name: "TEXAS-RAISED JAPANESE BROWN",
                                  price: "\$2,200",
                                ),
                              ),
                            ).toList(),
                          ),
                        ),
                        SizedBox(height: 50),
                        Text(
                          "Drinks",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xffF2F2F9),
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 115,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              10,
                              (i) => MyTabListingWidget(
                                menuItem: MenuItem(
                                  sId: "dr" + i.toString(),
                                  img: "assets/images/drink1 1.png",
                                  name: "Virgin Mohito",
                                  price: "\$1,200",
                                  isCookable: false,
                                ),
                              ),
                            ).toList(),
                          ),
                        ),
                        SizedBox(height: 50),
                        Text(
                          "Dessert",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xffF2F2F9),
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 115,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              10,
                              (i) => MyTabListingWidget(
                                menuItem: MenuItem(
                                  sId: "de" + i.toString(),
                                  img: "assets/images/cake 4 1.png",
                                  name: "Strawberry tres leche",
                                  price: "\$1,500",
                                  isCookable: false,
                                ),
                              ),
                            ).toList(),
                          ),
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
