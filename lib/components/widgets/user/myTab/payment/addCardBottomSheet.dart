import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuvlemobile/components/inputs/cardInputFormatter.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/styles/colors.dart';

class AddCardBottomSheet extends StatefulWidget {
  @override
  _AddCardBottomSheetState createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  FocusNode cardNumFN = FocusNode();
  FocusNode expiryDateFN = FocusNode();
  FocusNode cvvFN = FocusNode();
  FocusNode pinFN = FocusNode();

  @override
  void dispose() {
    cardNumFN.dispose();
    expiryDateFN.dispose();
    cvvFN.dispose();
    pinFN.dispose();
    super.dispose();
  }

  _handleSubmitted(BuildContext context) async {
    Navigator.pop(context);
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Add new card",
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Card Number',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffB9B9B9),
                  ),
                ),
                InputBox(
                  bottomMargin: 25,
                  hintText: "xxxx - xxxx - xxxx - xxxx",
                  textStyle: TextStyle(
                    fontSize: 24,
                    letterSpacing: -0.28,
                    color: Color(0xffF2F2F9),
                  ),
                  onSaved: (String val) {},
                  contentPadding: EdgeInsets.zero,
                  enabledBorderColor: Colors.white,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: cardNumFN,
                  nextFocusNode: expiryDateFN,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    CardNumberInputFormatter()
                  ],
                  onChange: (val) {
                    if (val.length == 27) {
                      cardNumFN.unfocus();
                      FocusScope.of(context).requestFocus(expiryDateFN);
                    }
                  },
                ),
                SizedBox(height: 40),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'MM / YY',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB9B9B9),
                              ),
                            ),
                            InputBox(
                              bottomMargin: 25,
                              hintText: "xx/xx",
                              textStyle: TextStyle(
                                fontSize: 24,
                                letterSpacing: -0.28,
                                color: Color(0xffF2F2F9),
                              ),
                              onSaved: (String val) {},
                              contentPadding: EdgeInsets.zero,
                              enabledBorderColor: Colors.white,
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              focusNode: expiryDateFN,
                              nextFocusNode: cvvFN,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                ExpiryDateInputFormatter()
                              ],
                              onChange: (val) {
                                if (val.length == 7) {
                                  expiryDateFN.unfocus();
                                  FocusScope.of(context).requestFocus(cvvFN);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'CVV',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB9B9B9),
                            ),
                          ),
                          InputBox(
                            bottomMargin: 25,
                            hintText: "xxx",
                            textStyle: TextStyle(
                              fontSize: 24,
                              letterSpacing: -0.28,
                              color: Color(0xffF2F2F9),
                            ),
                            onChange: (val) {
                              if (val.length == 3) {
                                cvvFN.unfocus();
                                FocusScope.of(context).requestFocus(pinFN);
                              }
                            },
                            onSaved: (String val) {},
                            contentPadding: EdgeInsets.zero,
                            enabledBorderColor: Colors.white,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            focusNode: cvvFN,
                            nextFocusNode: pinFN,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'PIN',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB9B9B9),
                            ),
                          ),
                          InputBox(
                            bottomMargin: 25,
                            hintText: "xxxx",
                            textStyle: TextStyle(
                              fontSize: 24,
                              letterSpacing: -0.28,
                              color: Color(0xffF2F2F9),
                            ),
                            onSaved: (String val) {},
                            contentPadding: EdgeInsets.zero,
                            enabledBorderColor: Colors.white,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            submitAction: () => _handleSubmitted(context),
                            focusNode: pinFN,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            onChange: (val) {
                              if (val.length == 4) {
                                pinFN.unfocus();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Functions().customButton(
              context,
              onTap: () => _handleSubmitted(context),
              width: screenSize.width,
              text: "Add Card",
              specificBorderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
