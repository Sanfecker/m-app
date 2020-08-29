import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/components/widgets/user/searchResultListingWidget.dart';
import 'package:nuvlemobile/models/skeltons/menus/item.dart';
import 'package:nuvlemobile/styles/colors.dart';

class SearchBottomSheet extends StatefulWidget {
  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Search",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xffF2F2F9),
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
              SizedBox(height: 20),
              InputBox(
                bottomMargin: 25,
                hintText: "Search...",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onSaved: (String val) {},
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      8,
                      (i) => SearchResultListingWidget(
                        menuItem: MenuItem(
                            sId: i.toString(),
                            cal: "56 Kcal",
                            description:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            img:
                                "assets/images/FAVPNG_barbecue-grill-beefsteak-beef-plate-grilling_PMai9z2w 2.png",
                            name: "TEXAS-RAISED JAPANESE BROWN CATTLE FROM HEARTBRAND BEEF, 14 OZ",
                            price: "\$850"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
