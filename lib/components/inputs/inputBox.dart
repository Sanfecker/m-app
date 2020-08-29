import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuvlemobile/styles/colors.dart';

class InputBox extends StatelessWidget {
  final Widget icon, prefix, prefixIcon;
  final double boxWidth, boxHeight;
  final int maxLines;
  final String hintText, labelText, initialValue;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final FocusNode focusNode, nextFocusNode;
  final VoidCallback submitAction;
  final Widget suffix, suffixIcon;
  final Color iconColor, enabledBorderColor;
  final bool obscureText, enableSuggestions;
  final double bottomMargin;
  final TextStyle textStyle;
  final FormFieldValidator<String> validateFunction;
  final void Function(String) onSaved, onChange;
  final Key key;
  final EdgeInsetsGeometry contentPadding;
  final List<TextInputFormatter> inputFormatters;

  //passing props in the Constructor.
  InputBox({
    this.key,
    this.prefix,
    this.maxLines = 1,
    this.boxHeight,
    this.boxWidth,
    this.controller,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.enableSuggestions = false,
    this.obscureText = false,
    this.textInputType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.icon,
    this.inputFormatters,
    this.iconColor,
    this.bottomMargin,
    this.textStyle = const TextStyle(
      fontSize: 16,
      color: Color(0xffF2F2F9),
      letterSpacing: 1,
    ),
    this.validateFunction,
    this.onChange,
    this.onSaved,
    this.enabledBorderColor = CustomColors.primary,
    this. contentPadding = const EdgeInsets.symmetric(horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: bottomMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (labelText != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                labelText,
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1,
                  color: Color(0xffA6A6A6),
                ),
              ),
            ),
          TextFormField(
            onChanged: onChange,
            style: textStyle,
            key: key,
            maxLines: maxLines,
            initialValue: initialValue,
            controller: controller,
            obscureText: obscureText,
            keyboardType: textInputType,
            validator: validateFunction,
            inputFormatters: inputFormatters,
            onSaved: onSaved,
            cursorColor: Colors.grey,
            textInputAction: textInputAction,
            focusNode: focusNode,
            onFieldSubmitted: (String term) {
              if (nextFocusNode != null) {
                focusNode.unfocus();
                FocusScope.of(context).requestFocus(nextFocusNode);
              } else {
                submitAction();
              }
            },
            enableSuggestions: enableSuggestions,
            decoration: InputDecoration(
              icon: icon,
              hintStyle: TextStyle(
                color: Colors.grey[800],
                fontSize: 15,
                letterSpacing: 1,
              ),
              hintText: hintText,
              prefix: prefix,
              prefixIcon: prefixIcon != null
                  ? Container(
                      padding: EdgeInsets.only(left: 20, right: 30),
                      child: prefixIcon,
                    )
                  : null,
              // labelText: labelText,
              suffix: suffix,
              contentPadding: contentPadding,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: enabledBorderColor,
                  width: 1,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: enabledBorderColor,
                  width: 1,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: enabledBorderColor,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
