import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/components/others/internetConnectionError.dart';
import 'package:nuvlemobile/components/widgets/user/searchResultListingWidget.dart';
import 'package:nuvlemobile/misc/enum.dart';
import 'package:nuvlemobile/models/providers/menus/menusProvider.dart';
import 'package:nuvlemobile/models/skeltons/menus/item.dart';
import 'package:nuvlemobile/models/skeltons/menus/menuData.dart';
import 'package:nuvlemobile/models/skeltons/menus/restaurantMenuType.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:provider/provider.dart';

class SearchBottomSheet extends StatefulWidget {
  final UserAccount userAccount;

  const SearchBottomSheet({Key key, this.userAccount}) : super(key: key);
  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

List<MenuItems> menuItems = List<MenuItems>();

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  List<MenuItems> filterList(List<MenuItems> listOfItems) {
    List<MenuItems> result = List<MenuItems>();
    List<int> list2 = List<int>();
    List<String> list = List<String>();
    listOfItems.forEach((element) {
      list.add(element.itemName);
    });
    for (var i in list) {
      list2.add(list.indexWhere((element) => element == i));
    }
    list2.toSet().forEach((element) {
      result.add(listOfItems[element]);
    });
    return result;
  }

  MenusProvider _menusProvider;
  String search;
  List<MenuType> type = [
    MenuType(
      menuType: "main-dishes",
      restaurantId: "5ef0a89b27322047f0f0ce71",
    ),
    MenuType(
      menuType: "drinks",
      restaurantId: "5ef0a89b27322047f0f0ce71",
    ),
    MenuType(
      menuType: "desserts",
      restaurantId: "5ef0a89b27322047f0f0ce71",
    ),
  ];

  @override
  void initState() {
    _menusProvider = Provider.of<MenusProvider>(context, listen: false);
    if (menuItems.isEmpty) {
      for (var i in type) {
        SchedulerBinding.instance.addPostFrameCallback(
            (_) => _menusProvider.fetchMenus(context, i, widget.userAccount));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: double.infinity,
          child: Column(
            children: <Widget>[
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Search",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xffF2F2F9),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 30,
                      color: CustomColors.primary100,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              InputBox(
                bottomMargin: 25,
                hintText: "Search...",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onSaved: (String val) {},
                onChange: (val) {
                  setState(() {
                    search = val;
                  });
                },
              ),
              Expanded(
                child: Consumer<MenusProvider>(
                  builder: (context, pro, child) {
                    switch (pro.apiRequestStatus) {
                      case APIRequestStatus.unInitialized:
                      case APIRequestStatus.unauthorized:
                      case APIRequestStatus.error:
                      case APIRequestStatus.loading:
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(CustomColors.primary),
                          ),
                        );
                        break;
                      case APIRequestStatus.loaded:
                        for (var i in type) {
                          if (pro.getPage(i)) {
                            SchedulerBinding.instance.addPostFrameCallback(
                              (_) => _menusProvider.fetchMoreMenus(
                                  context, i, widget.userAccount, 'next'),
                            );
                          }

                          var menu = pro.fetchMenuItems(i);
                          menuItems.addAll(menu);
                        }

                        return menuItems.length > 0 &&
                                search != null &&
                                search.isNotEmpty
                            ? ListView(
                                // controller: _scrollController,
                                padding: EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 12),
                                children: [
                                  ...filterList(menuItems).where((element) {
                                    if (element.categoryName != null)
                                      return element.itemName
                                              .toLowerCase()
                                              .split(' ')
                                              .contains(search.toLowerCase())
                                          ? true
                                          : element.categoryName
                                                      .toLowerCase() ==
                                                  search.toLowerCase()
                                              ? true
                                              : false;
                                    else
                                      return element.itemName
                                          .toLowerCase()
                                          .split(' ')
                                          .contains(search.toLowerCase());
                                  }).map((e) {
                                    return SearchResultListingWidget(
                                      menuItem: e,
                                    );
                                  }).toList(),
                                  if (pro.moreAPIRequestStatus ==
                                      APIRequestStatus.loading)
                                    Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            CustomColors.primary),
                                      ),
                                    ),
                                ],
                              )
                            : Center();
                        break;
                      case APIRequestStatus.connectionError:
                        return InternetConnectionError(refreshCallBack: () {
                          for (var i in type) {
                            SchedulerBinding.instance.addPostFrameCallback(
                              (_) => _menusProvider.fetchMenus(
                                  context, i, widget.userAccount),
                            );
                          }
                        });
                        break;
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
