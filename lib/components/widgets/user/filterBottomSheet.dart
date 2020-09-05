import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/inputs/customListTileCheckBox.dart';
import 'package:nuvlemobile/components/widgets/user/dietaryBottomSheet.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/menus/menusProvider.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

List<String> filter = List<String>();
bool _nut = false;
bool _sea = false;
bool _lac = false;
bool _glu = false;

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  void _onNutChanged(bool newValue) => setState(() {
        _nut = newValue;
        if (newValue == true && !filter.contains('Nut Allergies')) {
          filter.add('Nut Allergies');
        }
        if (newValue == false && filter.contains('Nut Allergies')) {
          filter.remove('Nut Allergies');
        }
      });
  void _onSeaChanged(bool newValue) => setState(() {
        _sea = newValue;
        if (newValue == true && !filter.contains('Sea Food')) {
          filter.add('Sea Food');
        }
        if (newValue == false && filter.contains('Sea Food')) {
          filter.remove('Sea Food');
        }
      });
  void _onLacChanged(bool newValue) => setState(() {
        _lac = newValue;
        if (newValue == true && !filter.contains('Lactose - Intolerant')) {
          filter.add('Lactose - Intolerant');
        }
        if (newValue == false && filter.contains('Lactose - Intolerant')) {
          filter.remove('Lactose - Intolerant');
        }
      });
  void _onGluChanged(bool newValue) => setState(() {
        _glu = newValue;
        if (newValue == true && !filter.contains('Glucose')) {
          filter.add('Glucose');
        }
        if (newValue == false && filter.contains('Glucose')) {
          filter.remove('Glucose');
        }
      });

  void _onVegeChanged(bool newValue) => setState(() {
        if (newValue == true && !filter.contains('Vegetarian')) {
          filter.add('Vegetarian');
        }
        if (newValue == false && filter.contains('Vegetarian')) {
          filter.remove('Vegetarian');
        }
        if (newValue == true && !dietaryRestrictions.contains('Vegetarian')) {
          dietaryRestrictions.add('Vegetarian');
        }
        if (newValue == false && dietaryRestrictions.contains('Vegetarian')) {
          dietaryRestrictions.remove('Vegetarian');
        }
      });
  void _onVeganChanged(bool newValue) => setState(() {
        if (newValue == true && !filter.contains('Vegan')) {
          filter.add('Vegan');
        }
        if (newValue == false && filter.contains('Vegan')) {
          filter.remove('Vegan');
        }
        if (newValue == true && !dietaryRestrictions.contains('Vegan')) {
          dietaryRestrictions.add('Vegan');
        }
        if (newValue == false && dietaryRestrictions.contains('Vegan')) {
          dietaryRestrictions.remove('Vegan');
        }
      });
  void _onGlutenChanged(bool newValue) => setState(() {
        if (newValue == true && !filter.contains('Gluten - free')) {
          filter.add('Gluten - free');
        }
        if (newValue == false && filter.contains('Gluten - free')) {
          filter.remove('Gluten - free');
        }
        if (newValue == true &&
            !dietaryRestrictions.contains('Gluten - free')) {
          dietaryRestrictions.add('Gluten - free');
        }
        if (newValue == false &&
            dietaryRestrictions.contains('Gluten - free')) {
          dietaryRestrictions.remove('Gluten - free');
        }
      });
  void _onHalalChanged(bool newValue) => setState(() {
        if (newValue == true && !filter.contains('Halal')) {
          filter.add('Halal');
        }
        if (newValue == false && filter.contains('Halal')) {
          filter.remove('Halal');
        }
        if (newValue == true && !dietaryRestrictions.contains('Halal')) {
          dietaryRestrictions.add('Halal');
        }
        if (newValue == false && dietaryRestrictions.contains('Halal')) {
          dietaryRestrictions.remove('Halal');
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
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
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
          Spacer(
            flex: 2,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
          Spacer(
            flex: 2,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
          Spacer(),
        ],
      ),
    );
  }
}
