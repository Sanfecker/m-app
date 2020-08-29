import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/icons/callWaiterIcon.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/components/widgets/user/sidesBottomSheet.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/settings.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/menus/menuData.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/menus/orderComplete.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  final UserAccount userAccount;
  final MenuItems menuItem;

  OrderItem({Key key, @required this.userAccount, @required this.menuItem})
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  _handleSubmitted(BuildContext ctx) async {
    Functions().showLoadingDialog(ctx);
    _formKey.currentState.save();
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(ctx, listen: false);
    try {
      ApiRequestModel apiRequestModel = await orderProvider
          .order(userAccount, [orderProvider.getSingleItem(menuItem)]);
      if (apiRequestModel.isSuccessful) {
        Navigator.pop(ctx);
        Functions()
            .transitTo(ctx, OrderComplete(), PageTransitionType.downToUp);
      } else {
        Navigator.pop(ctx);
        showInSnackBar(apiRequestModel.errorMessage);
      }
    } catch (e) {
      Navigator.pop(ctx);
      showInSnackBar("Internal Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          CallWaiterIcon(),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: menuItem.itemTags.length > 0
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: menuItem.itemTags
                      .map(
                        (e) => Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: FlatButton(
                            color: Color(0xff4A444A),
                            child: Text(
                              e.tagName,
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: StadiumBorder(),
                            onPressed: () => print("Hey"),
                          ),
                        ),
                      )
                      .toList(),
                ),
                CachedNetworkImage(
                  imageUrl: menuItem.imageUrl ?? '',
                  width: 215,
                  height: 245,
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
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Consumer<OrderProvider>(
                  builder: (context, pro, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkResponse(
                        onTap: () => pro.changeOrderQuantity(menuItem, false),
                        child: Text(
                          "—",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          pro.getSingleItem(menuItem).orderQuantity.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      InkResponse(
                        onTap: () => pro.changeOrderQuantity(menuItem),
                        child: Text(
                          "+",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff363A47),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(right: 14),
                      child: Text(
                        menuItem.itemName.toLowerCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Text(
                    Functions.getCurrencySymbol(menuItem.currency) +
                        menuItem.price,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xffF2F2F9),
                    ),
                  )
                ],
              ),
            ),
            if (menuItem.cookingPreferences != null &&
                menuItem.cookingPreferences.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Cooking Preference',
                    style: TextStyle(
                      color: Color(0xffF2F2F9),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Wrap(
                          spacing: 18,
                          children: menuItem.cookingPreferences
                              .map(
                                (e) => Consumer<OrderProvider>(
                                    builder: (context, pro, child) {
                                  bool isMarked = pro
                                              .getSingleItem(menuItem)
                                              .selectedCookingPreference !=
                                          null
                                      ? pro
                                              .getSingleItem(menuItem)
                                              .selectedCookingPreference
                                              .toLowerCase() ==
                                          e.toLowerCase()
                                      : menuItem.cookingPreferences.first ==
                                          e.toLowerCase();
                                  return FlatButton(
                                    color: isMarked
                                        ? Color(0xffCFB06F)
                                        : Color(0xff363A47),
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          color: isMarked
                                              ? Colors.black
                                              : Colors.white,
                                          letterSpacing: 0.3,
                                          fontSize: 13),
                                    ),
                                    shape: StadiumBorder(),
                                    onPressed: () => pro
                                        .changeCookingPreference(menuItem, e),
                                  );
                                }),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            if (menuItem.sides != null && menuItem.sides.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Select a side',
                    style: TextStyle(
                      color: Color(0xffF2F2F9),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 12),
                  Consumer<OrderProvider>(
                    builder: (context, pro, child) {
                      List<MenuItems> confirmedSides =
                          pro.getSingleItem(menuItem).confirmedSides;
                      return Text(
                        confirmedSides != null && confirmedSides.length > 0
                            ? confirmedSides.length == 1
                                ? "Dish Side: 1 Side"
                                : "Dish Side: ${confirmedSides.length} Sides"
                            : "No Selected Side",
                      );
                    },
                  ),
                  SizedBox(height: 12),
                  FlatButton(
                    color: Color(0xff363A47),
                    child: Text(
                      "Pick Sides +",
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.3,
                          fontSize: 13),
                    ),
                    shape: StadiumBorder(),
                    onPressed: () => Functions.openBottomSheet(
                        context,
                        SidesBottomSheet(
                            menuItem: menuItem, userAccount: userAccount),
                        true),
                  ),
                ],
              ),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: InputBox(
                bottomMargin: 40,
                labelText: "Add Note",
                hintText: "Any preference",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onSaved: (String val) {
                  Provider.of<OrderProvider>(context, listen: false)
                      .saveOrderNote(val, menuItem);
                },
              ),
            ),
            Text(
              'To go?',
              style: TextStyle(
                color: Color(0xffF2F2F9),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
            Consumer<OrderProvider>(
              builder: (context, pro, child) {
                bool takeAway = pro.getSingleItem(menuItem).takeAway ?? false;
                return FlatButton(
                  onPressed: () => pro.isTakeAway(menuItem, !takeAway),
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 14),
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          checkColor: CustomColors.primary100,
                          activeColor: Colors.transparent,
                          value: takeAway,
                          onChanged: (val) => pro.isTakeAway(menuItem, val),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Text(
                        "Select Takeaway",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 60),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 60,
                    child: FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xffE3C079),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Functions().customButton(
                  context,
                  onTap: () => _handleSubmitted(context),
                  width: screenSize.width * 0.50,
                  text: "Send Order",
                  color: CustomColors.primary900,
                ),
              ],
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
