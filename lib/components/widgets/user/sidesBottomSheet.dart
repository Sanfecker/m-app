import 'package:Nuvle/misc/enum.dart';
import 'package:Nuvle/models/providers/menus/menusProvider.dart';
import 'package:Nuvle/models/skeltons/menus/restaurantMenuType.dart';
import 'package:flutter/material.dart';
import 'package:Nuvle/components/widgets/user/selectableListingWidget.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/providers/user/order/orderProvider.dart';
import 'package:Nuvle/models/skeltons/menus/menuData.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:provider/provider.dart';

class SidesBottomSheet extends StatefulWidget {
  final UserAccount userAccount;

  const SidesBottomSheet({Key key, @required this.userAccount})
      : super(key: key);

  @override
  _SidesBottomSheetState createState() => _SidesBottomSheetState();
}

class _SidesBottomSheetState extends State<SidesBottomSheet> {
  _handleSubmitted(BuildContext context) {
    // Provider.of<OrderProvider>(context, listen: false)
    //     .confirmedSideSelection(menuItem);
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sides",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Color(0xffF2F2F9),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Consumer2<OrderProvider, MenusProvider>(
                  builder: (context, pro, pro2, child) {
                switch (pro2.apiRequestStatus) {
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
                    List<MenuItems> menuItems = pro2.fetchMenuItems(
                      MenuType(
                        menuType: "main-dishes",
                        restaurantId: "5ef0a89b27322047f0f0ce71",
                      ),
                    );
                    List<List<MenuItems>> result = List<List<MenuItems>>();
                    menuItems.forEach((e) {
                      if (e.sides != null && e.sides.isNotEmpty)
                        e.sides.forEach(
                          (element) {
                            result.add([e, element]);
                          },
                        );
                    });
                    return result.isNotEmpty
                        ? Flexible(
                            child: ListView(
                              children: result.map((e) {
                                return SelectableListingWidget(
                                    menuItem: e[1],
                                    parent: e[0],
                                    userAccount: widget.userAccount);
                              }).toList(),
                            ),
                          )
                        : Center(
                            child: Text("Nothing to show"),
                          );
                    break;
                  default:
                    return Container();
                }
              }),
              Functions().customButton(
                context,
                onTap: () => _handleSubmitted(context),
                width: screenSize.width,
                text: "Add Side",
                specificBorderRadius: BorderRadius.circular(5),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
