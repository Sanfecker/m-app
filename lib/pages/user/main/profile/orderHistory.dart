import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/homePageProvider.dart';
import 'package:nuvlemobile/models/providers/mainPageProvider.dart';
import 'package:nuvlemobile/models/providers/user/order/orderHistoryProvider.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/profile/profile.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  final UserAccount userAccount;

  const OrderHistory({Key key, @required this.userAccount}) : super(key: key);
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: page == 'home'
            ? Consumer<HomePageProvider>(
                builder: (context, pro, child) => Container(
                  margin: EdgeInsets.only(left: 20),
                  height: screenSize.height * 0.1,
                  child: GestureDetector(
                    onTap: () => pro.selectedIndex = 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFFD2B271),
                          size: 20,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xFFD2B271),
                            fontSize: 14,
                            letterSpacing: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Consumer<MainPageProvider>(
                builder: (context, pro, child) => Container(
                  margin: EdgeInsets.only(left: 20),
                  height: screenSize.height * 0.1,
                  child: GestureDetector(
                    onTap: () => pro.selectedIndex = 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFFD2B271),
                          size: 20,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xFFD2B271),
                            fontSize: 14,
                            letterSpacing: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
        leadingWidth: 200,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: screenSize.width * 0.60,
                margin: EdgeInsets.only(bottom: 32, top: 20),
                child: Text(
                  "Orders",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Consumer<OrderProvider>(
                builder: (context, pro, child) {
                  return Column(
                    children: [
                      if (pro.history.isNotEmpty)
                        Divider(color: Color(0xff4a444a)),
                      ...ListTile.divideTiles(
                        tiles: pro.history.map(
                          (i) => ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            // Functions().transitTo(context,
                            //     ProfileSettings(userAccount: widget.userAccount)),
                            title: Text(
                              i[0].itemName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                i[1],
                                style: TextStyle(
                                  color: Color(0xffA6A6A6),
                                ),
                              ),
                            ),
                            trailing: Container(
                              margin: EdgeInsets.only(right: 25),
                              child: Icon(
                                NuvleIcons.icon_right,
                                color: Color(0xffC7C7D4),
                              ),
                            ),
                          ),
                        ),
                        color: Color(0xff4a444a),
                        context: context,
                      ),
                      if (pro.history.isNotEmpty)
                        Divider(color: Color(0xff4a444a)),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
