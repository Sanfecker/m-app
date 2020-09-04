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
import 'package:nuvlemobile/pages/user/main/profile/profile.dart';
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
    page = 'main';
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
      floatingActionButton: GestureDetector(
        onTap: () => Functions().scaleTo(context, MyTab()),
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.primary100,
            border: Border.all(
              color: Colors.black,
              width: 1.5,
            ),
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.only(
            right: 10,
          ),
          padding: EdgeInsets.all(5),
          child: Icon(
            NuvleIcons.floating_v4_1,
            size: 60,
            color: Color(0xFF4A444A),
          ),
        ),
      ),
      appBar: AppBar(
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: SearchIcon(userAccount: widget.userAccount),
        actions: <Widget>[
          CallWaiterIcon(),
        ],
        bottom: TabBar(
          controller: tabController,
          indicator:
              CircleTabIndicator(color: CustomColors.primary100, radius: 3.5),
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
                      textStyle: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                    InkResponse(
                      child: Icon(
                        NuvleIcons.frame_109,
                        size: 20,
                      ),
                      onTap: () => Functions.openBottomSheet(
                          context, FilterBottomSheet(), true),
                    ),
                  ] +
                  [
                    BottomAppButton(
                      name: "Dietary +",
                      onPressed: () => Functions.openBottomSheet(
                          context, DietaryBottomSheet()),
                    ),
                    BottomAppButton(
                      name: "Sides +",
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
                        (e) => GestureDetector(
                          onTap: e.onPressed,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            child: Text(
                              e.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: tabs
                  .map((e) => MenuTabListing(
                      userAccount: widget.userAccount, menuType: e.menuType))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
