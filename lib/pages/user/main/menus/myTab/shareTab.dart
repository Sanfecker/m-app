import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/menus/myTab/tabSharingCompleted.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';

class ShareTab extends StatefulWidget {
  final UserAccount userAccount;

  const ShareTab({Key key, @required this.userAccount}) : super(key: key);
  @override
  _ShareTabState createState() => _ShareTabState();
}

class _ShareTabState extends State<ShareTab> {
  _handleSubmitted(BuildContext context) async {
    Functions().scaleToReplace(
      context,
      TabSharingCompleted(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  "Your Group Code",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color(0xffF2F2F9),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  width: screenSize.width,
                  child: Text(
                    widget.userAccount.tab.attributes.groupCode,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.iBMPlexSans(
                      fontSize: 64,
                      letterSpacing: -0.28,
                      color: Colors.white,
                    ),
                  ),
                  margin: EdgeInsets.only(top: 30, bottom: 40),
                  decoration: BoxDecoration(
                      color: CustomColors.licoRice,
                      borderRadius: BorderRadius.circular(5)),
                ),
                FlatButton(
                  onPressed: () => Clipboard.setData(ClipboardData(
                      text: widget.userAccount.tab.attributes.groupCode)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.content_copy,
                        size: 19,
                        color: CustomColors.primary900,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Copy Code",
                        style: TextStyle(
                          color: CustomColors.primary900,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Invite someone to your Tab",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(height: 60),
                InputBox(
                  bottomMargin: 50,
                  labelText: "Email Address",
                  hintText: "Enter email address",
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  submitAction: () => _handleSubmitted(context),
                  onSaved: (String val) {},
                ),
                Functions().customButton(
                  context,
                  onTap: () => _handleSubmitted(context),
                  width: screenSize.width,
                  text: "Send Invite",
                  hasIcon: true,
                  trailing: Icon(
                    NuvleIcons.icon_right,
                    color: Color(0xff474551),
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
