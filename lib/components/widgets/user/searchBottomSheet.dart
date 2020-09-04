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

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  ScrollController _scrollController = ScrollController();
  List<MenuItems> menuItems = List<MenuItems>();
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
    _scrollController.addListener(scrollListener);
    for (var i in type) {
      SchedulerBinding.instance.addPostFrameCallback(
          (_) => _menusProvider.fetchMenus(context, i, widget.userAccount));
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  scrollListener() {
    for (var i in type) {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange &&
          _menusProvider.moreAPIRequestStatus != APIRequestStatus.loading) {
        SchedulerBinding.instance.addPostFrameCallback(
          (_) => _menusProvider.fetchMoreMenus(context, i, widget.userAccount),
        );
      }
    }
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
                          menuItems.addAll(pro.fetchMenuItems(i));
                          var menu = menuItems.toSet();
                          menuItems = menu.toList();
                        }
                        return menuItems.length > 0
                            ? ListView(
                                controller: _scrollController,
                                padding: EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 12),
                                children: [
                                  ...menuItems
                                      .where((element) => element.itemName
                                          .split(' ')
                                          .contains(search))
                                      .map((e) {
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
                            : Center(
                                child: Text("Nothing to show"),
                              );
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
