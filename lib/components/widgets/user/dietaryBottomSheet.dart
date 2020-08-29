import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/inputs/customListTileCheckBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/styles/colors.dart';

class DietaryBottomSheet extends StatefulWidget {
  @override
  _DietaryBottomSheetState createState() => _DietaryBottomSheetState();
}

class _DietaryBottomSheetState extends State<DietaryBottomSheet> {
  bool _vege = true;
  bool _vegan = false;
  bool _gluten = false;
  bool _halal = false;

  void _onVegeChanged(bool newValue) => setState(() => _vege = newValue);
  void _onVeganChanged(bool newValue) => setState(() => _vegan = newValue);
  void _onGlutenChanged(bool newValue) => setState(() => _gluten = newValue);
  void _onHalalChanged(bool newValue) => setState(() => _halal = newValue);

  _handleSubmitted(BuildContext context) async {
    Navigator.pop(context);
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
                "Dietary",
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
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: <Widget>[
              CustomListTileCheckBox(
                text: "Vegetarian",
                value: _vege,
                onChanged: _onVegeChanged,
              ),
              CustomListTileCheckBox(
                text: "Vegan",
                value: _vegan,
                onChanged: _onVeganChanged,
              ),
              CustomListTileCheckBox(
                text: "Gluten - free",
                value: _gluten,
                onChanged: _onGlutenChanged,
              ),
              CustomListTileCheckBox(
                text: "Halal",
                value: _halal,
                onChanged: _onHalalChanged,
              ),
            ],
          ),
        ),
        Functions().customButton(
          context,
          onTap: () => _handleSubmitted(context),
          width: screenSize.width,
          text: "Apply",
          specificBorderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
      ],
    );
  }
}
