import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/inputs/customListTileCheckBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/styles/colors.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool _nut = true;
  bool _sea = false;
  bool _lac = false;
  bool _glu = false;

  void _onNutChanged(bool newValue) => setState(() => _nut = newValue);
  void _onSeaChanged(bool newValue) => setState(() => _sea = newValue);
  void _onLacChanged(bool newValue) => setState(() => _lac = newValue);
  void _onGluChanged(bool newValue) => setState(() => _glu = newValue);

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
    return ListView(
      // mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.start,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Filter",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
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
        SizedBox(height: 50),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Dietary",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: CustomColors.primary100,
            ),
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
        SizedBox(height: 50),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Allergens",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: CustomColors.primary100,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: <Widget>[
              CustomListTileCheckBox(
                text: "Nut",
                value: _nut,
                onChanged: _onNutChanged,
              ),
              CustomListTileCheckBox(
                text: "Sea Food",
                value: _sea,
                onChanged: _onSeaChanged,
              ),
              CustomListTileCheckBox(
                text: "Lactose - Intolerant",
                value: _lac,
                onChanged: _onLacChanged,
              ),
              CustomListTileCheckBox(
                text: "Glucose",
                value: _glu,
                onChanged: _onGluChanged,
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
