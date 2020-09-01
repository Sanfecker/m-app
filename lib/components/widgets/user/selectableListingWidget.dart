import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/settings.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/menus/menuData.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:provider/provider.dart';

class SelectableListingWidget extends StatefulWidget {
  final MenuItems menuItem;
  final MenuItems parent;
  final UserAccount userAccount;

  const SelectableListingWidget(
      {Key key,
      @required this.menuItem,
      @required this.parent,
      @required this.userAccount})
      : super(key: key);

  @override
  _SelectableListingWidgetState createState() =>
      _SelectableListingWidgetState();
}

class _SelectableListingWidgetState extends State<SelectableListingWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, pro, child) {
      bool isSelected =
          pro.getSingleItem(widget.parent).selectedSides != null &&
              pro
                      .getSingleItem(widget.parent)
                      .selectedSides
                      .indexWhere((e) => e.itemId == widget.menuItem.itemId) !=
                  -1;
      return InkResponse(
        onTap: () => isSelected
            ? pro.removeSelectedSide(widget.parent, widget.menuItem)
            : pro.addSelectedSide(widget.parent, widget.menuItem),
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: widget.menuItem.imageUrl ?? '',
                  width: 109,
                  height: 125,
                  errorWidget: (context, url, error) => Container(
                    child: Image.asset(
                      Settings.placeholderImageSmall,
                      width: 109,
                      height: 125,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                  placeholder: (BuildContext context, String val) {
                    return Container(
                      child: Image.asset(
                        Settings.placeholderImageSmall,
                        width: 109,
                        height: 125,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.menuItem.itemName,
                        softWrap: true,
                        style: TextStyle(fontSize: 15, letterSpacing: 0.3),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '${widget.menuItem.calorieCount} Kcal',
                        style: TextStyle(
                            fontSize: 10,
                            color: Color(0xffF2F2F9),
                            letterSpacing: 0.3),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          widget.menuItem.description,
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xffF2F2F9),
                              letterSpacing: 0.3),
                        ),
                      ),
                      Text(
                        Functions.getCurrencySymbol(widget.menuItem.currency) +
                            widget.menuItem.price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    checkColor: CustomColors.primary100,
                    activeColor: Colors.transparent,
                    value:
                        widget.parent.confirmedSides.contains(widget.menuItem),
                    onChanged: (val) {
                      setState(() {
                        if (val) {
                          widget.parent.confirmedSides.add(widget.menuItem);
                        } else {
                          widget.parent.confirmedSides.remove(widget.menuItem);
                        }
                      });
                    },
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: CustomColors.licoRice,
          ),
        ),
      );
    });
  }
}
