import 'package:flutter/material.dart';

import 'package:Nuvle/components/widgets/user/myTab/payment/enterCouponButtonSheet.dart';
import 'package:Nuvle/components/widgets/user/myTab/payment/savedCardsBottomSheet.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';

class PayBottomSheet extends StatefulWidget {
  final UserAccount userAccount;
  final double amount;

  const PayBottomSheet({
    Key key,
    this.userAccount,
    this.amount,
  }) : super(key: key);
  @override
  _PayBottomSheetState createState() => _PayBottomSheetState();
}

class _PayBottomSheetState extends State<PayBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 3,
              width: 68,
              decoration: BoxDecoration(
                color: Color(0xffF2F2F9).withOpacity(0.4),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(bottom: 30, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Payment Options",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: CustomColors.primary100,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Choose any of the payment options to make your payment",
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(bottom: 20),
                      child: FlatButton(
                        onPressed: () => Functions.openBottomSheet(
                            context,
                            SavedCardsBottomSheet(
                                userAccount: widget.userAccount)),
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              NuvleIcons.icon_credit_cart,
                              color: Colors.white,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text(
                                "Saved Cards",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(bottom: 20),
                      child: FlatButton(
                        onPressed: () => print("Hye"),
                        color: Color(0xffF2F2F9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.only(left: 24, right: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/apppay 2.png",
                              height: 34,
                              width: 77,
                            ),
                            Icon(
                              NuvleIcons.icon_right,
                              color: Color(0xff474551),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(bottom: 20),
                      child: FlatButton(
                        onPressed: () => print("Hye"),
                        color: Color(0xffF2F2F9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.only(left: 24, right: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/Group 109.png",
                              height: 34,
                              width: 77,
                            ),
                            Icon(
                              NuvleIcons.icon_right,
                              color: Color(0xff474551),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(bottom: 20),
                      child: FlatButton(
                        onPressed: () => Functions.openBottomSheet(
                            context, EnterCouponBottomSheet(), true),
                        color: Color(0xff9F9FAF).withOpacity(0.20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.only(left: 24, right: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Enter Coupon Code",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              NuvleIcons.icon_right,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 17),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
