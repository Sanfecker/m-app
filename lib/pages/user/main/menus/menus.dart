import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuvlemobile/components/icons/callWaiterIcon.dart';
import 'package:nuvlemobile/components/icons/searchIcon.dart';
import 'package:nuvlemobile/components/others/tabBarIndicator.dart';
import 'package:nuvlemobile/components/widgets/user/categoriesBottomSheet.dart';
import 'package:nuvlemobile/components/widgets/user/dietaryBottomSheet.dart';
import 'package:nuvlemobile/components/widgets/user/filterBottomSheet.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/skeltons/menus/bottomAppBarButton.dart';
import 'package:nuvlemobile/models/skeltons/menus/restaurantMenuType.dart';
import 'package:nuvlemobile/models/skeltons/others/mainTabBarItem.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/menus/appBarTabs/menuTabListingPage.dart';
import 'package:nuvlemobile/pages/user/main/menus/myTab/myTab.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class Menus extends StatefulWidget {
  final UserAccount userAccount;

  const Menus({Key key, @required this.userAccount}) : super(key: key);
  @override
  _MenusState createState() => _MenusState();
}

class _MenusState extends State<Menus> with SingleTickerProviderStateMixin {
  TabController tabController;
  List<MainTabBarItem> tabs = [];

  @override
  void initState() {
    tabs = [
      MainTabBarItem(
        name: 'Food',
        menuType: MenuType(
          menuType: "main-dishes",
          restaurantId: "5ef0a89b27322047f0f0ce71",
        ),
      ),
      MainTabBarItem(
        name: 'Drink',
        menuType: MenuType(
          menuType: "drinks",
          restaurantId: "5ef0a89b27322047f0f0ce71",
        ),
      ),
      MainTabBarItem(
        name: 'Starters',
        menuType: MenuType(
          menuType: "main-dishes",
          restaurantId: "5ef0a89b27322047f0f0ce71",
        ),
      ),
      MainTabBarItem(
        name: 'Dessert',
        menuType: MenuType(
          menuType: "desserts",
          restaurantId: "5ef0a89b27322047f0f0ce71",
        ),
      ),
    ];
    tabController = TabController(vsync: this, length: tabs.length);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: 10, bottom: 30),
        child: FloatingActionButton(
          onPressed: () => Functions().scaleTo(context, MyTab()),
          child: Icon(
            NuvleIcons.floating_v4_1,
            size: 50,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0)),
          side: BorderSide(color: Colors.black, width: 1.5)),
          // shape: (side: BorderSide(color: Colors.greyblue, width: 2.0)),
          backgroundColor: CustomColors.primary100,
        ),
      ),
      appBar: AppBar(
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: SearchIcon(),
        actions: <Widget>[
          CallWaiterIcon(),
        ],
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.only(bottom: 14),
            child: Column(
              children: <Widget>[
                TabBar(
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 25),
                  controller: tabController,
                  indicator: CircleTabIndicator(
                      color: CustomColors.primary100, radius: 3.5),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  indicatorWeight: 5,
                  labelColor: CustomColors.primary100,
                  unselectedLabelColor: Color(0xff666666),
                  tabs: tabs
                      .map(
                        (e) => Tab(
                          child: Text(
                            e.name,
                            style: GoogleFonts.lato(
                              textStyle:
                                  TextStyle(fontSize: 18, letterSpacing: 0.4),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: <Widget>[
                      InkResponse(
                        child: Icon(
                          NuvleIcons.frame_109,
                          size: 18,
                        ),
                        onTap: () => Functions.openBottomSheet(
                            context, FilterBottomSheet(), true),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BottomAppButton(
                            name: "Dietary +",
                            onPressed: () => Functions.openBottomSheet(
                                context, DietaryBottomSheet()),
                          ),
                          BottomAppButton(
                            name: "Sides",
                            onPressed: () => print("hEY"),
                            // Functions.openBottomSheet(
                            //     context, SidesBottomSheet(), true),
                          ),
                          BottomAppButton(
                            name: "Categories",
                            onPressed: () => Functions.openBottomSheet(
                                context, CategoriesBottomSheet(), true),
                          ),
                        ]
                            .map(
                              (e) => Container(
                                height: 28,
                                child: OutlineButton(
                                  shape: StadiumBorder(),
                                  onPressed: e.onPressed,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    e.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(90),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: tabs
            .map((e) => MenuTabListing(
                userAccount: widget.userAccount, menuType: e.menuType))
            .toList(),
      ),
    );
  }
}
