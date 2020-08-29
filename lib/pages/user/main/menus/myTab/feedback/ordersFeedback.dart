import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/icons/callWaiterIcon.dart';
import 'package:nuvlemobile/components/widgets/user/feedbackListingWidget.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/skeltons/menus/item.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class OrdersFeedback extends StatefulWidget {
  @override
  _OrdersFeedbackState createState() => _OrdersFeedbackState();
}

class _OrdersFeedbackState extends State<OrdersFeedback> {
  _handleSubmitted(BuildContext context) async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Functions().customButton(
              context,
              onTap: () => _handleSubmitted(context),
              width: screenSize.width,
              text: "THANK YOU",
              hasIcon: true,
              trailing: Icon(
                NuvleIcons.icon_checkmark,
                color: Color(0xff474551),
                size: 14,
              ), 
            ),
            // SizedBox(height: 15),
            // Container(
            //   width: screenSize.width,
            //   height: 60,
            //   child: FlatButton(
            //     onPressed: () => Navigator.pop(context),
            //     child: Text(
            //       "Skip",
            //       style: TextStyle(
            //         letterSpacing: 1,
            //         color: Color(0xffD2B271),
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold
            //       ),
            //     ),
            //   ),
            // ),
          ],
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
              SizedBox(height: 20),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      8,
                      (i) => FeedbackListingWidget(
                        menuItem: MenuItem(
                            sId: i.toString(),
                            cal: "56 Kcal",
                            description:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            img:
                                "assets/images/FAVPNG_barbecue-grill-beefsteak-beef-plate-grilling_PMai9z2w 2.png",
                            name: "Vegetarian Pho",
                            price: "\$600"),
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
