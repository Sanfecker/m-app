import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/widgets/user/myTab/payment/addCardBottomSheet.dart';
import 'package:nuvlemobile/misc/enum.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/skeltons/payment/paymentCard.dart';
import 'package:nuvlemobile/pages/user/main/menus/myTab/payment/paymentComplete.dart';
import 'package:nuvlemobile/pages/user/scan/learnGroupCode.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class SavedCardsBottomSheet extends StatefulWidget {
  @override
  _SavedCardsBottomSheetState createState() => _SavedCardsBottomSheetState();
}

class _SavedCardsBottomSheetState extends State<SavedCardsBottomSheet> {
  String _selectedCard = "visa-022993-1928";

  _handleSubmitted(BuildContext context) async {
    Navigator.popUntil(context, (route) => route.isFirst);
    Functions().scaleTo(context, PaymentComplete());
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 3,
          width: 68,
          decoration: BoxDecoration(
            color: Color(0xffF2F2F9).withOpacity(0.4),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Select Card Option",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: CustomColors.primary100,
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
        ),
        SizedBox(height: 30),
        Flexible(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Column(
                    children: [
                  PaymentCard(
                      cardNumber: "**** **** **** 4902",
                      sId: "master-290929-4902",
                      type: PaymentCardType.master),
                  PaymentCard(
                      cardNumber: "**** **** **** 1928",
                      sId: "visa-022993-1928",
                      type: PaymentCardType.visa),
                ]
                        .map(
                          (e) => Container(
                            height: 60,
                            margin: EdgeInsets.only(bottom: 20),
                            child: FlatButton(
                              onPressed: () =>
                                  setState(() => _selectedCard = e.sId),
                              color: Color(0xffF5F5F5),
                              shape: RoundedRectangleBorder(
                                  side: _selectedCard == e.sId
                                      ? BorderSide(
                                          color: Color(0xffE5C27A), width: 2)
                                      : BorderSide.none,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      if (e.type == PaymentCardType.visa)
                                        Image.asset(
                                          "assets/images/visa.png",
                                          height: 35,
                                          width: 35,
                                        )
                                      else if (e.type == PaymentCardType.master)
                                        Image.asset(
                                          "assets/images/master.png",
                                          height: 35,
                                          width: 35,
                                        ),
                                      Container(
                                        margin: EdgeInsets.only(left: 30),
                                        child: Text(
                                          e.cardNumber,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_selectedCard == e.sId)
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 7, bottom: 5, top: 5, left: 5),
                                      child: Icon(
                                        NuvleIcons.icon_checkmark,
                                        size: 6,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffE5C27A),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList()),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 30,
                  child: OutlineButton(
                    onPressed: () => Functions.openBottomSheet(
                        context, AddCardBottomSheet(), true),
                    padding: EdgeInsets.symmetric(horizontal: 29),
                    child: Text(
                      "Add new card",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    shape: StadiumBorder(),
                  ),
                ),
                SizedBox(height: 30)
              ],
            ),
          ),
        ),
        Functions().customButton(
          context,
          onTap: () => _handleSubmitted(context),
          width: screenSize.width,
          text: "Pay \$175",
          specificBorderRadius: BorderRadius.zero,
          hasIcon: true,
          trailing: Icon(
            NuvleIcons.icon_right,
            color: Color(0xff474551),
          ),
        ),
      ],
    );
  }
}
