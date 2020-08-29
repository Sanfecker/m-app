import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/inputs/customListTileCheckBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/styles/colors.dart';

class CategoriesBottomSheet extends StatefulWidget {
  @override
  _CategoriesBottomSheetState createState() => _CategoriesBottomSheetState();
}

class _CategoriesBottomSheetState extends State<CategoriesBottomSheet> {
  bool _sea = true;
  bool _children = false;
  bool _grill = false;
  bool _lebrard = false;

  void _onSeaChanged(bool newValue) => setState(() => _sea = newValue);
  void _onChildrenChanged(bool newValue) => setState(() => _children = newValue);
  void _onGrillChanged(bool newValue) => setState(() => _grill = newValue);
  void _onLebrardChanged(bool newValue) => setState(() => _lebrard = newValue);

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
