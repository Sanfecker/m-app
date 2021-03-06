import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:Nuvle/components/others/internetConnectionError.dart';
import 'package:Nuvle/components/widgets/user/categoriesBottomSheet.dart';
import 'package:Nuvle/components/widgets/user/dietaryBottomSheet.dart';
import 'package:Nuvle/components/widgets/user/filterBottomSheet.dart';
import 'package:Nuvle/components/widgets/user/listingWidget.dart';
import 'package:Nuvle/misc/enum.dart';
import 'package:Nuvle/models/providers/menus/menusProvider.dart';
import 'package:Nuvle/models/skeltons/menus/menuData.dart';
import 'package:Nuvle/models/skeltons/menus/restaurantMenuType.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:provider/provider.dart';

class MenuTabListing extends StatefulWidget {
  final UserAccount userAccount;
  final MenuType menuType;

  const MenuTabListing(
      {Key key, @required this.userAccount, @required this.menuType})
      : super(key: key);

  @override
  _MenuTabListingState createState() => _MenuTabListingState();
}

class _MenuTabListingState extends State<MenuTabListing> {
  ScrollController _scrollController = ScrollController();
  MenusProvider _menusProvider;

  @override
  void initState() {
    _menusProvider = Provider.of<MenusProvider>(context, listen: false);
    _scrollController.addListener(scrollListener);
    SchedulerBinding.instance.addPostFrameCallback((_) => _menusProvider
        .fetchMenus(context, widget.menuType, widget.userAccount));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        _menusProvider.moreAPIRequestStatus != APIRequestStatus.loading) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => _menusProvider.fetchMoreMenus(
            context, widget.menuType, widget.userAccount, 'next'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenusProvider>(
      builder: (context, pro, child) {
        switch (pro.apiRequestStatus) {
          case APIRequestStatus.unInitialized:
          case APIRequestStatus.unauthorized:
          case APIRequestStatus.error:
          case APIRequestStatus.loading:
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(CustomColors.primary),
              ),
            );
            break;
          case APIRequestStatus.loaded:
            List<MenuItems> menuItems = pro.fetchMenuItems(widget.menuType);
            return menuItems.length > 0
                ? ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                    children: [
                      ...menuItems
                          .where((element) {
                            if (filter != null && filter.isNotEmpty) {
                              if (element.dietaryRestrictions.toList().isEmpty)
                                return false;
                              else
                                return element.dietaryRestrictions
                                    .toList()
                                    .any((el) => filter.contains(el));
                            } else if (dietaryRestrictions != null &&
                                dietaryRestrictions.isNotEmpty) {
                              if (element.dietaryRestrictions.toList().isEmpty)
                                return false;
                              else
                                return element.dietaryRestrictions.toList().any(
                                    (el) => dietaryRestrictions.contains(el));
                            } else
                              return true;
                          })
                          .where((element) {
                            if (categories != null && categories.isNotEmpty)
                              return categories.contains(element.categoryName);
                            else
                              return true;
                          })
                          .map(
                            (e) => ListingWidget(
                              menuItem: e,
                              userAccount: widget.userAccount,
                              isFirst: menuItems.indexOf(e) == 0,
                            ),
                          )
                          .toList(),
                      if (pro.moreAPIRequestStatus == APIRequestStatus.loading)
                        Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(CustomColors.primary),
                          ),
                        ),
                    ],
                  )
                : Center(
                    child: Text("Nothing to show"),
                  );
            break;
          case APIRequestStatus.connectionError:
            return InternetConnectionError(
              refreshCallBack: () =>
                  SchedulerBinding.instance.addPostFrameCallback(
                (_) => _menusProvider.fetchMenus(
                    context, widget.menuType, widget.userAccount),
              ),
            );
            break;
          default:
            return Container();
        }
      },
    );
  }
}
