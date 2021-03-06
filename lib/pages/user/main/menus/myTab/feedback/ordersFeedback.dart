import 'package:Nuvle/components/animations/scaleTransition.dart';
import 'package:flutter/material.dart';
import 'package:Nuvle/components/icons/callWaiterIcon.dart';
import 'package:Nuvle/components/widgets/user/feedbackListingWidget.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/providers/menus/menusProvider.dart';
import 'package:Nuvle/models/providers/user/order/orderProvider.dart';
import 'package:Nuvle/models/skeltons/menus/item.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/pages/user/homepage.dart';
import 'package:Nuvle/pages/user/main/mainPage.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class OrdersFeedback extends StatefulWidget {
  final UserAccount userAccount;

  const OrdersFeedback({this.userAccount});
  @override
  _OrdersFeedbackState createState() => _OrdersFeedbackState();
}

class _OrdersFeedbackState extends State<OrdersFeedback> {
  _handleSubmitted(BuildContext context) async {
    OrderProvider _orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    _orderProvider.feedback();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.push(
      context,
      ScaleRoute(
        page: HomePage(
          userAccount: widget.userAccount,
        ),
      ),
    );
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
          height: double.infinity,
          width: double.infinity,
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
              Consumer<OrderProvider>(
                builder: (context, pro, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => FeedbackListingWidget(
                          menuItem: pro.feedbackList[index],
                          userAccount: widget.userAccount),
                      itemCount: pro.feedbackList.length,
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
