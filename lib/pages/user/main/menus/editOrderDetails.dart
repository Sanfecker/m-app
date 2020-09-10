import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Nuvle/components/icons/callWaiterIcon.dart';
import 'package:Nuvle/components/inputs/inputBox.dart';
import 'package:Nuvle/components/widgets/user/sidesBottomSheet.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/misc/settings.dart';
import 'package:Nuvle/models/providers/user/order/orderProvider.dart';
import 'package:Nuvle/models/skeltons/api/apiRequestModel.dart';
import 'package:Nuvle/models/skeltons/menus/menuData.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/pages/user/main/menus/orderComplete.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EditOrderDetails extends StatefulWidget {
  final UserAccount userAccount;
  final MenuItems menuItem;

  EditOrderDetails(
      {Key key, @required this.userAccount, @required this.menuItem})
      : super(key: key);

  @override
  _EditOrderDetailsState createState() => _EditOrderDetailsState();
}

class _EditOrderDetailsState extends State<EditOrderDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _autoValidate = false;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  _handleSubmitted(BuildContext ctx) {
    Navigator.pop(ctx);
  }

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.clear();
    if (Provider.of<OrderProvider>(context, listen: false)
            .getSingleItem(widget.menuItem)
            .note !=
        null) {
      _controller.text = Provider.of<OrderProvider>(context, listen: false)
          .getSingleItem(widget.menuItem)
          .note;
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Color(0xff4A444A),
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                        onTap: () =>
                            pro.changeOrderQuantity(widget.menuItem, false),
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
                          pro
                              .getSingleItem(widget.menuItem)
                              .orderQuantity
                              .toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      InkResponse(
                        onTap: () => pro.changeOrderQuantity(widget.menuItem),
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
            if (widget.menuItem.cookingPreferences != null &&
                widget.menuItem.cookingPreferences.isNotEmpty &&
                widget.menuItem.cookingPreferences.any((element) {
                  if (element != '')
                    return true;
                  else
                    return false;
                }))
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
                              .where((element) => element != '')
                              .map(
                                (e) => Consumer<OrderProvider>(
                                    builder: (context, pro, child) {
                                  bool isMarked = pro
                                              .getSingleItem(widget.menuItem)
                                              .selectedCookingPreference !=
                                          null
                                      ? pro
                                              .getSingleItem(widget.menuItem)
                                              .selectedCookingPreference
                                              .toLowerCase() ==
                                          e.toLowerCase()
                                      : false;
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
                                    shape: StadiumBorder(
                                        side: pro
                                                    .getSingleItem(
                                                        widget.menuItem)
                                                    .selectedCookingPreference ==
                                                null
                                            ? BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              )
                                            : BorderSide.none),
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
            // if (widget.menuItem.sides != null &&
            //     widget.menuItem.sides.isNotEmpty)
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text(
            //         'Select a side',
            //         style: TextStyle(
            //           color: Color(0xffF2F2F9),
            //           fontWeight: FontWeight.bold,
            //           fontSize: 16,
            //         ),
            //       ),
            //       SizedBox(height: 12),
            //       Consumer<OrderProvider>(
            //         builder: (context, pro, child) {
            //           List<MenuItems> confirmedSides =
            //               pro.getSingleItem(widget.menuItem).confirmedSides;
            //           return Text(
            //             confirmedSides != null && confirmedSides.length > 0
            //                 ? confirmedSides.length == 1
            //                     ? "Dish Side: 1 Side"
            //                     : "Dish Side: ${confirmedSides.length} Sides"
            //                 : "No Selected Side",
            //           );
            //         },
            //       ),
            //       SizedBox(height: 12),
            //       FlatButton(
            //           color: Color(0xff363A47),
            //           child: Text(
            //             "Pick Sides +",
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 letterSpacing: 0.3,
            //                 fontSize: 13),
            //           ),
            //           shape: StadiumBorder(),
            //           onPressed: () async {
            //             await Functions.openBottomSheet(
            //                 context,
            //                 SidesBottomSheet(
            //                     menuItem: widget.menuItem,
            //                     userAccount: widget.userAccount),
            //                 true);
            //             setState(() {});
            //           }),
            //     ],
            //   ),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: InputBox(
                enabledBorderColor: _controller.text.isEmpty
                    ? Colors.red
                    : CustomColors.primary,
                controller: _controller,
                bottomMargin: 40,
                labelText: "Add Note",
                hintText: "Any preference",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChange: (String val) {
                  setState(() {});
                  Provider.of<OrderProvider>(context, listen: false)
                      .saveOrderNote(val, widget.menuItem);
                },
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
                  onPressed: () => pro.isTakeAway(widget.menuItem, !takeAway),
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
            Functions().customButton(
              context,
              onTap: () => _handleSubmitted(context),
              width: screenSize.width,
              text: "Submit",
              color: CustomColors.primary900,
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
