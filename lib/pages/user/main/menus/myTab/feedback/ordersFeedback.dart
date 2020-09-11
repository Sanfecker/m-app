import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/icons/callWaiterIcon.dart';
import 'package:nuvlemobile/components/widgets/user/feedbackListingWidget.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/menus/menusProvider.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/menus/item.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/homepage.dart';
import 'package:nuvlemobile/pages/user/main/mainPage.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class OrdersFeedback extends StatefulWidget {
  final UserAccount userAccount;

  const OrdersFeedback({Key key, this.userAccount}) : super(key: key);
  @override
  _OrdersFeedbackState createState() => _OrdersFeedbackState();
}

class _OrdersFeedbackState extends State<OrdersFeedback> {
  _handleSubmitted(BuildContext context) async {
    OrderProvider _orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    _orderProvider.feedback();
    Functions().scaleToReplace(
      context,
      HomePage(userAccount: widget.userAccount),
      removePreviousRoots: true,
    );
  }

  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false)
        .feedbackList
        .forEach((element) {
      element.rating = 5;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Functions().customButton(
              context,
              onTap: () => _handleSubmitted(context),
              width: screenSize.width,
              text: "THANK YOU",
              hasIcon: true,
              trailing: Icon(
                NuvleIcons.icon_checkmark,
                color: Color(0xff474551),
                size: 14,
              ),
            ),
            // SizedBox(height: 15),
            // Container(
            //   width: screenSize.width,
            //   height: 60,
            //   child: FlatButton(
            //     onPressed: () => Navigator.pop(context),
            //     child: Text(
            //       "Skip",
            //       style: TextStyle(
            //         letterSpacing: 1,
            //         color: Color(0xffD2B271),
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: <Widget>[
          CallWaiterIcon(
            userAccount: widget.userAccount,
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Feedback",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Color(0xffF2F2F9),
                ),
              ),
              SizedBox(height: 20),
              Flexible(child:
                  Consumer<OrderProvider>(builder: (context, pro, child) {
                return ListView(
                    children: pro.feedbackList.map((e) {
                  FeedbackListingWidget(
                    menuItem: e,
                    userAccount: widget.userAccount,
                  );
                }).toList());
              })),
            ],
          ),
        ),
      ),
    );
  }
}
