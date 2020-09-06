import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/icons/callWaiterIcon.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/settings.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/menus/menuData.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/menus/orderItem.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'orderComplete.dart';

class OrderNow extends StatefulWidget {
  final UserAccount userAccount;
  final MenuItems menuItem;

  const OrderNow({Key key, @required this.userAccount, @required this.menuItem})
      : super(key: key);

  @override
  _OrderNowState createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
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
      ApiRequestModel apiRequestModel = await orderProvider.order(
          widget.userAccount, [orderProvider.getSingleItem(widget.menuItem)]);
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 1150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2992,
                  child: Row(
                    mainAxisAlignment: widget.menuItem.itemTags.length > 0
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.menuItem.itemTags
                            .map(
                              (e) => Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Color(0xff4A444A),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  e.tagName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.3,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      CachedNetworkImage(
                        imageUrl: widget.menuItem.imageUrl ?? '',
                        width: MediaQuery.of(context).size.width * 0.6,
                        filterQuality: FilterQuality.high,
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
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            widget.menuItem.itemName.toLowerCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Text(
                        Functions.getCurrencySymbol(widget.menuItem.currency) +
                            widget.menuItem.price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color(0xffF2F2F9),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),
                if (widget.menuItem.cookingPreferences != null &&
                    widget.menuItem.cookingPreferences.isNotEmpty)
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
                              children: widget.menuItem.cookingPreferences
                                  .map(
                                    (e) => Consumer<OrderProvider>(
                                        builder: (context, pro, child) {
                                      bool isMarked = pro
                                                  .getSingleItem(
                                                      widget.menuItem)
                                                  .selectedCookingPreference !=
                                              null
                                          ? pro
                                                  .getSingleItem(
                                                      widget.menuItem)
                                                  .selectedCookingPreference
                                                  .toLowerCase() ==
                                              e.toLowerCase()
                                          : widget.menuItem.cookingPreferences
                                                  .first ==
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
                                        onPressed: () =>
                                            pro.changeCookingPreference(
                                                widget.menuItem, e),
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
                if (widget.menuItem.sides != null &&
                    widget.menuItem.sides.isNotEmpty)
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommended Pairings',
                          style: TextStyle(
                            color: Color(0xffD4B472),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'These pair well with ${widget.menuItem.itemName}',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 12),
                        Flexible(
                          child: Container(
                            child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: widget.menuItem.sides.map((e) {
                                  return Container(
                                    // height: 83,
                                    width: 114,
                                    margin: EdgeInsets.only(
                                      right: 12,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Consumer<OrderProvider>(
                                          builder: (context, pro, child) =>
                                              GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                widget.menuItem.confirmedSides
                                                        .contains(e)
                                                    ? widget
                                                        .menuItem.confirmedSides
                                                        .remove(e)
                                                    : widget
                                                        .menuItem.confirmedSides
                                                        .add(e);
                                              });
                                            },
                                            child: Container(
                                              height: 114,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xFFD5B572),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              // padding: const EdgeInsets.all(
                                              //   17,
                                              // ),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: e.imageUrl ?? '',
                                                    width: 114,
                                                    height: 114,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Container(
                                                      child: Image.asset(
                                                        Settings
                                                            .placeholderImageSmall,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (BuildContext context,
                                                            String val) {
                                                      return Image.asset(
                                                        Settings
                                                            .placeholderImageSmall,
                                                      );
                                                    },
                                                    fit: BoxFit.cover,
                                                  ),
                                                  if (widget
                                                      .menuItem.confirmedSides
                                                      .contains(e))
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                          229,
                                                          194,
                                                          122,
                                                          0.7,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      height: double.infinity,
                                                      width: 114,
                                                      child: Icon(
                                                        Icons.check,
                                                        color:
                                                            Color(0xFF4C4B5E),
                                                        size: 30,
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          e.itemName,
                                          softWrap: true,
                                          style: TextStyle(
                                            letterSpacing: 0.3,
                                            fontSize: 14,
                                            color: Color(0xFFF2F2F9),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        // Spacer(),
                                        Text(
                                          Functions.getCurrencySymbol(
                                                  widget.menuItem.currency) +
                                              e.price,
                                          style: TextStyle(
                                            letterSpacing: 0.3,
                                            fontSize: 12,
                                            color: Color(0xFFF2F2F9),
                                          ),
                                        ),
                                        Expanded(child: SizedBox())
                                      ],
                                    ),
                                  );
                                }).toList()),
                          ),
                        ),
                      ],
                    ),
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
                          .saveOrderNote(val, widget.menuItem);
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
                    bool takeAway =
                        pro.getSingleItem(widget.menuItem).takeAway ?? false;
                    return FlatButton(
                      onPressed: () =>
                          pro.isTakeAway(widget.menuItem, !takeAway),
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
                              onChanged: (val) =>
                                  pro.isTakeAway(widget.menuItem, val),
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
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
