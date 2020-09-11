import 'package:flutter/material.dart';
import 'package:Nuvle/components/inputs/pinInputBox.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/styles/colors.dart';

class EnterCouponBottomSheet extends StatefulWidget {
  @override
  _EnterCouponBottomSheetState createState() => _EnterCouponBottomSheetState();
}

class _EnterCouponBottomSheetState extends State<EnterCouponBottomSheet> {
  TextEditingController textEditingController = TextEditingController();

  _handleSubmitted(String pin) async {
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
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
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Enter Code",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: CustomColors.primary100,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Enter your Coupon Code below",
                          style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
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
                PinInput(
                  controller: textEditingController,
                  autofocus: false,
                  maxLength: 5,
                  highlight: true,
                  highlightColor: CustomColors.primary,
                  pinBoxWidth: 60,
                  defaultBorderColor:
                      Theme.of(context).primaryColor.withOpacity(0.6),
                  hasTextBorderColor: CustomColors.primary,
                  hasError: false,
                  wrapAlignment: WrapAlignment.center,
                  // onDone: (text) => _handleSubmitted(text),
                  pinBoxDecoration:
                      ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                  pinTextStyle: TextStyle(fontSize: 24),
                  pinTextAnimatedSwitcherTransition:
                      ProvidedPinBoxTextAnimation.scalingTransition,
                  pinTextAnimatedSwitcherDuration: Duration(milliseconds: 100),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
          Functions().customButton(
            context,
            onTap: () => textEditingController.text.length > 0
                ? _handleSubmitted(textEditingController.text)
                : null,
            width: screenSize.width,
            text: "Apply",
            specificBorderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
