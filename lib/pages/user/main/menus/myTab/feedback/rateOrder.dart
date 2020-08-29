import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/icons/callWaiterIcon.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/menus/item.dart';
import 'package:nuvlemobile/models/skeltons/menus/menuData.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class RateOrder extends StatefulWidget {
  final MenuItems menuItem;

  const RateOrder({Key key, @required this.menuItem}) : super(key: key);
  @override
  _RateOrderState createState() => _RateOrderState();
}

class _RateOrderState extends State<RateOrder> {
  double _rating = 1;

  _handleSubmitted(BuildContext context) async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
        child: Functions().customButton(
          context,
          onTap: () => _handleSubmitted(context),
          width: screenSize.width,
          text: "Okay",
          hasIcon: true,
          trailing: Icon(
            NuvleIcons.icon_checkmark,
            color: Color(0xff474551),
            size: 14,
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: <Widget>[
          CallWaiterIcon(),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Feedback",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Color(0xffF2F2F9),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 80),
                      Center(
                        child: Consumer<OrderProvider>(
                          builder: (context, pro, child) {
                            double rating =
                                pro.getSingleItem(widget.menuItem).rating;
                            return Image.asset(
                              rating == 1.0
                                  ? "assets/images/Frame 119.png"
                                  : rating == 2.0
                                      ? "assets/images/Frame 119 (1).png"
                                      : "assets/images/Frame 119 (2).png",
                              height: 240,
                              width: 279,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 120),
                      SliderTheme(
                        data: SliderThemeData(
                          thumbShape:
                              RectangleSliderThumbShape(enabledThumbRadius: 15),
                          trackHeight: 2,
                        ),
                        child: Consumer<OrderProvider>(
                          builder: (context, pro, child) => Slider(
                            value: pro.getSingleItem(widget.menuItem).rating,
                            min: 1.0,
                            max: 3.0,
                            divisions: 2,
                            onChanged: (val) =>
                                pro.rateOrder(widget.menuItem, val),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Poor",
                            style: TextStyle(letterSpacing: 0.3, fontSize: 16),
                          ),
                          Text(
                            "Very Good",
                            style: TextStyle(letterSpacing: 0.3, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
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

class RectangleSliderThumbShape extends SliderComponentShape {
  /// Create a slider thumb that draws a circle.
  const RectangleSliderThumbShape({
    this.enabledThumbRadius = 10.0,
    this.disabledThumbRadius,
  });

  /// The preferred radius of the round thumb shape when the slider is enabled.
  ///
  /// If it is not provided, then the material default of 10 is used.
  final double enabledThumbRadius;

  /// The preferred radius of the round thumb shape when the slider is disabled.
  ///
  /// If no disabledRadius is provided, then it is equal to the
  /// [enabledThumbRadius]
  final double disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center, {Animation<double> activationAnimation, Animation<double> enableAnimation, bool isDiscrete, TextPainter labelPainter, RenderBox parentBox, SliderThemeData sliderTheme, TextDirection textDirection, double value, double textScaleFactor, Size sizeWithOverflow}) {
    assert(context != null);
    assert(center != null);
    assert(enableAnimation != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromCircle(
            center: center,
            radius: radiusTween.evaluate(enableAnimation),
          ),
          Radius.circular(5)),
      Paint()..color = colorTween.evaluate(enableAnimation),
    );
  }
}
