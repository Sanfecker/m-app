import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class OrderHistory extends StatefulWidget {
  final UserAccount userAccount;

  const OrderHistory({Key key, @required this.userAccount}) : super(key: key);
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: screenSize.width * 0.60,
                margin: EdgeInsets.only(bottom: 60, top: 20),
                child: Text(
                  "Orders",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Column(children: [
                Divider(color: Colors.white),
                ...ListTile.divideTiles(
                  tiles: List.generate(
                    4,
                    (i) => ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                      onTap: () => print("Hey"),
                      // Functions().transitTo(context,
                      //     ProfileSettings(userAccount: widget.userAccount)),
                      title: Text(
                        "Le Bardin",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          "Thur 25th 2020",
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
                  color: Colors.white,
                  context: context,
                ),
                Divider(color: Colors.white),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
