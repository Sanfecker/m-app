import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/inputs/customListTileCheckBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/menus/menusProvider.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:provider/provider.dart';

class CategoriesBottomSheet extends StatefulWidget {
  @override
  _CategoriesBottomSheetState createState() => _CategoriesBottomSheetState();
}

bool _sea = false;
bool _children = false;
bool _grill = false;
bool _lebrard = false;
List<String> categories = List<String>();

class _CategoriesBottomSheetState extends State<CategoriesBottomSheet> {
  void _onSeaChanged(bool newValue) => setState(() {
        _sea = newValue;
        if (newValue == true && !categories.contains('Seafood')) {
          categories.add('Seafood');
        }
        if (newValue == false && categories.contains('Seafood')) {
          categories.remove('Seafood');
        }
      });
  void _onChildrenChanged(bool newValue) => setState(() {
        _children = newValue;
        if (newValue == true && !categories.contains('Children Dishes')) {
          categories.add('Children Dishes');
        }
        if (newValue == false && categories.contains('Children Dishes')) {
          categories.remove('Children Dishes');
        }
      });
  void _onGrillChanged(bool newValue) => setState(() {
        _grill = newValue;
        if (newValue == true && !categories.contains('From the Grill')) {
          categories.add('From the Grill');
        }
        if (newValue == false && categories.contains('From the Grill')) {
          categories.remove('From the Grill');
        }
      });
  void _onLebrardChanged(bool newValue) => setState(() {
        _lebrard = newValue;
        if (newValue == true && !categories.contains('Le Brardin Entrees')) {
          categories.add('Le Brardin Entrees');
        }
        if (newValue == false && categories.contains('Le Brardin Entrees')) {
          categories.remove('Le Brardin Entrees');
        }
      });

  _handleSubmitted(BuildContext context) async {
    MenusProvider _menusProvider;
    _menusProvider = Provider.of<MenusProvider>(context, listen: false);
    _menusProvider.setState();
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
                "Categories",
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
                text: "Seafood",
                value: _sea,
                onChanged: _onSeaChanged,
              ),
              CustomListTileCheckBox(
                text: "Children Dishes",
                value: _children,
                onChanged: _onChildrenChanged,
              ),
              CustomListTileCheckBox(
                text: "From the Grill",
                value: _grill,
                onChanged: _onGrillChanged,
              ),
              CustomListTileCheckBox(
                text: "Le Brardin Entrees",
                value: _lebrard,
                onChanged: _onLebrardChanged,
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
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
