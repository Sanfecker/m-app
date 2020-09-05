import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/inputs/customListTileCheckBox.dart';
import 'package:nuvlemobile/components/widgets/user/filterBottomSheet.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/menus/menusProvider.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:provider/provider.dart';

class DietaryBottomSheet extends StatefulWidget {
  @override
  _DietaryBottomSheetState createState() => _DietaryBottomSheetState();
}

List<String> dietaryRestrictions = List<String>();
bool _vege = false;
bool _vegan = false;
bool _gluten = false;
bool _halal = false;

class _DietaryBottomSheetState extends State<DietaryBottomSheet> {
  void _onVegeChanged(bool newValue) => setState(() {
        _vege = newValue;
        if (newValue == true && !dietaryRestrictions.contains('Vegetarian')) {
          dietaryRestrictions.add('Vegetarian');
        }
        if (newValue == false && dietaryRestrictions.contains('Vegetarian')) {
          dietaryRestrictions.remove('Vegetarian');
        }
        if (newValue == true && !filter.contains('Vegetarian')) {
          filter.add('Vegetarian');
        }
        if (newValue == false && filter.contains('Vegetarian')) {
          filter.remove('Vegetarian');
        }
      });
  void _onVeganChanged(bool newValue) => setState(() {
        _vegan = newValue;
        if (newValue == true && !dietaryRestrictions.contains('Vegan')) {
          dietaryRestrictions.add('Vegan');
        }
        if (newValue == false && dietaryRestrictions.contains('Vegan')) {
          dietaryRestrictions.remove('Vegan');
        }
        if (newValue == true && !filter.contains('Vegan')) {
          filter.add('Vegan');
        }
        if (newValue == false && filter.contains('Vegan')) {
          filter.remove('Vegan');
        }
      });
  void _onGlutenChanged(bool newValue) => setState(() {
        _gluten = newValue;
        if (newValue == true &&
            !dietaryRestrictions.contains('Gluten - free')) {
          dietaryRestrictions.add('Gluten - free');
        }
        if (newValue == false &&
            dietaryRestrictions.contains('Gluten - free')) {
          dietaryRestrictions.remove('Gluten - free');
        }
        if (newValue == true && !filter.contains('Gluten - free')) {
          filter.add('Gluten - free');
        }
        if (newValue == false && filter.contains('Gluten - free')) {
          filter.remove('Gluten - free');
        }
      });
  void _onHalalChanged(bool newValue) => setState(() {
        _halal = newValue;
        if (newValue == true && !dietaryRestrictions.contains('Halal')) {
          dietaryRestrictions.add('Halal');
        }
        if (newValue == false && dietaryRestrictions.contains('Halal')) {
          dietaryRestrictions.remove('Halal');
        }
        if (newValue == true && !filter.contains('Halal')) {
          filter.add('Halal');
        }
        if (newValue == false && filter.contains('Halal')) {
          filter.remove('Halal');
        }
      });

  _handleSubmitted(BuildContext context) async {
    MenusProvider _menusProvider;
    _menusProvider = Provider.of<MenusProvider>(context, listen: false);
    _menusProvider.setState();
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      // mainAxisSize: MainAxisSize.min,
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
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: ListView(
              children: <Widget>[
                CustomListTileCheckBox(
                  text: "Vegetarian",
                  value: dietaryRestrictions.contains('Vegetarian'),
                  onChanged: _onVegeChanged,
                ),
                CustomListTileCheckBox(
                  text: "Vegan",
                  value: dietaryRestrictions.contains('Vegan'),
                  onChanged: _onVeganChanged,
                ),
                CustomListTileCheckBox(
                  text: "Gluten - free",
                  value: dietaryRestrictions.contains('Gluten - free'),
                  onChanged: _onGlutenChanged,
                ),
                CustomListTileCheckBox(
                  text: "Halal",
                  value: dietaryRestrictions.contains('Halal'),
                  onChanged: _onHalalChanged,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Functions().customButton(
            context,
            onTap: () => _handleSubmitted(context),
            width: screenSize.width,
            text: "Apply",
            specificBorderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
