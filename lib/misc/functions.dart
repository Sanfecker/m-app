import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nuvlemobile/components/animations/scaleTransition.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:page_transition/page_transition.dart';

class Functions {
  static bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  static String getCurrencySymbol(String currency) {
    switch (currency) {
      case "USD":
        return "\$";
        break;
      case "NGN":
        return "N";
        break;
      default:
        return "\$";
    }
  }

  static openBottomSheet(BuildContext context, Widget widget,
      [bool isScrollControlled = false]) async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        context: context,
        isScrollControlled: isScrollControlled,
        builder: (context) => widget);
  }

  showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Container(
          height: 80,
          child: Container(
            width: 5,
            child: Center(
              child: SpinKitFadingCircle(
                color: CustomColors.primary,
                size: 50,
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget customButton(BuildContext context,
      {String text,
      bool hasIcon = false,
      Widget trailing,
      leading,
      double width,
      double height = 60,
      double borderRadius = 5,
      BorderRadiusGeometry specificBorderRadius,
      Color color,
      Color textColor,
      double textFontSize,
      letterSpacing,
      FontWeight fontWeight,
      void Function() onTap}) {
    return Container(
      height: height,
      width: width,
      child: RaisedButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius:
              specificBorderRadius ?? BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.zero,
        child: Ink(
          decoration: BoxDecoration(
            color: color ?? CustomColors.primary100,
            borderRadius:
                specificBorderRadius ?? BorderRadius.circular(borderRadius),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: width,
              minHeight: height,
            ),
            alignment: Alignment.center,
            child: hasIcon
                ? Container(
                    padding: EdgeInsets.only(left: 30, right: 60),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          " " + text,
                          style: TextStyle(
                            color: textColor ?? Color(0xff474551),
                            fontSize: textFontSize ?? 18,
                            letterSpacing: letterSpacing ?? 0.3,
                            fontWeight: fontWeight ?? FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        trailing
                      ],
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? Color(0xff474551),
                      fontSize: textFontSize ?? 16,
                      letterSpacing: letterSpacing ?? 1.2,
                      fontWeight: fontWeight ?? FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      ),
    );
  }

  Widget customOutlineButton(
    BuildContext context, {
    String text,
    bool hasIcon = false,
    Widget trailing,
    leading,
    double width,
    double height = 60,
    Color color,
    Color textColor,
    double textFontSize,
    letterSpacing,
    FontWeight fontWeight,
    void Function() onTap,
    Color borderColor = CustomColors.primary,
    double borderRadius = 5,
  }) {
    return Container(
      height: height ?? 60,
      width: width,
      child: OutlineButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.zero,
        borderSide: BorderSide(
          color: borderColor,
        ),
        highlightedBorderColor: CustomColors.primary,
        highlightColor: Colors.grey[800],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: hasIcon
              ? Container(
                  padding: EdgeInsets.only(left: 30, right: 60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        " " + text,
                        style: TextStyle(
                          color: textColor ?? CustomColors.primary100,
                          fontSize: textFontSize ?? 18,
                          letterSpacing: letterSpacing ?? 0.3,
                          fontWeight: fontWeight ?? FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      trailing
                    ],
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? CustomColors.primary100,
                    fontSize: textFontSize ?? 16,
                    letterSpacing: letterSpacing ?? 1.2,
                    fontWeight: fontWeight ?? FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }

  Future<Object> navigateTo(BuildContext context, Widget page) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<Object> transitTo(BuildContext context, Widget page,
      [PageTransitionType type]) {
    return Navigator.of(context).push(
      PageTransition(
        type: type ?? PageTransitionType.rightToLeft,
        child: page,
      ),
    );
  }

  Future<Object> transitToReplace(BuildContext context, Widget page,
      {bool removePreviousRoots = false}) {
    return removePreviousRoots
        ? Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              type: PageTransitionType.leftToRight,
              child: page,
            ),
            (Route route) => false,
          )
        : Navigator.of(context).pushReplacement(
            PageTransition(
              type: PageTransitionType.leftToRight,
              child: page,
            ),
          );
  }

  Future<Object> scaleTo(BuildContext context, Widget page) {
    return Navigator.of(context).push(
      ScaleRoute(
        page: page,
      ),
    );
  }

  Future<Object> scaleToReplace(BuildContext context, Widget page,
      {bool removePreviousRoots = false}) {
    return removePreviousRoots
        ? Navigator.of(context).pushAndRemoveUntil(
            ScaleRoute(
              page: page,
            ),
            (Route route) => false,
          )
        : Navigator.of(context).pushReplacement(
            ScaleRoute(
              page: page,
            ),
          );
  }
}
