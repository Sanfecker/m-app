import 'package:flutter/material.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/skeltons/menus/item.dart';
import 'package:nuvlemobile/pages/user/main/menus/myTab/feedback/rateOrder.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class FeedbackListingWidget extends StatefulWidget {
  final MenuItem menuItem;

  const FeedbackListingWidget({Key key, @required this.menuItem})
      : super(key: key);

  @override
  _FeedbackListingWidgetState createState() => _FeedbackListingWidgetState();
}

class _FeedbackListingWidgetState extends State<FeedbackListingWidget> {
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      // onTap: () =>
      //     Functions().transitTo(context, RateOrder(menuItem: widget.menuItem)),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                widget.menuItem.img,
                width: 86,
                height: 86,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                height: 86,
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.menuItem.name,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        NuvleIcons.unhappy_1,
                        NuvleIcons.face_1,
                        NuvleIcons.scared_1,
                        NuvleIcons.smile_1,
                        NuvleIcons.smile__1__1,
                      ]
                          .map(
                            (e) => Container(
                              margin: EdgeInsets.only(right: 9),
                              child: Icon(
                                e,
                                color: e == NuvleIcons.smile_1
                                    ? Color(0xffCCAD6E)
                                    : Color(0xff9F9FAF),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 86,
              child: Icon(
                NuvleIcons.icon_chevron_right,
                color: CustomColors.primary,
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
  }
}
