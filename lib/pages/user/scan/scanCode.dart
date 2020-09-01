import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuvlemobile/misc/settings.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/user/tabProvider.dart';
import 'package:nuvlemobile/models/providers/user/userAccountProvider.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/user/scanResponse.dart';
import 'package:nuvlemobile/models/skeltons/user/tab.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/mainPage.dart';
import 'package:nuvlemobile/pages/user/scan/scanissuccess.dart';
import 'package:nuvlemobile/pages/user/scan/learnGroupCode.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:nuvlemobile/pages/user/scan/scanSuccessful.dart';
import 'package:nuvlemobile/models/providers/mainPageProvider.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/pages/user/main/menus/orderComplete.dart';
import 'package:page_transition/page_transition.dart';

class ScanCodePage extends StatefulWidget {
  final UserAccount userAccount;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ScanCodePage({@required this.userAccount, @required this.scaffoldKey});
  @override
  _ScanCodePageState createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  TextEditingController textEditingController = TextEditingController();

  void showInSnackBar(String value) {
    widget.scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  _handleSubmitted(String code) async {
    Functions().showLoadingDialog(context);
    try {
      ApiRequestModel apiRequestModel =
          await Provider.of<TabProvider>(context, listen: false)
              .joinTabByCode(code, widget.userAccount);
      if (apiRequestModel.isSuccessful) {
        TabModel tab = apiRequestModel.result;
        widget.userAccount.tab = tab;
        Provider.of<UserAccountProvider>(context, listen: false)
            .setCurrentUserTabs(tab);
        Navigator.pop(context);
        Functions().transitToReplace(
            context, ScanSuccessfulPage(userAccount: widget.userAccount),
            removePreviousRoots: true);
      } else {
        Navigator.pop(context);
        await Fluttertoast.showToast(
          msg: apiRequestModel.errorMessage,
          textColor: Colors.black,
          backgroundColor: CustomColors.primary,
        );
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
      await Fluttertoast.showToast(
        msg: "Internal Error",
        textColor: Colors.black,
        backgroundColor: CustomColors.primary,
      );
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Widget scanner = Container(
    padding: EdgeInsets.all(30),
    height: 200,
    child: Image.asset(
      'assets/images/Group (2).png',
      fit: BoxFit.fitHeight,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              // margin: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    width: screenSize.width * 0.60,
                    height: screenSize.width * 0.15,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nice to see you,",
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                        Text("${widget.userAccount.attributes.firstname}.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                color: CustomColors.primary))
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: screenSize.width * 0.80,
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Scan your table's QR code to open a tab for yourself.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffF2F2F9),
                          letterSpacing: 1,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 5,),
            Container(
                height: 250,
                width: screenSize.width,
                child: GestureDetector(
                  child: scanner,
                  onTap: () {
                    setState(() {
                      scanner = QRView(
                        key: qrKey,
                        onQRViewCreated: (QRViewController controller) {
                          this.controller = controller;
                          controller.scannedDataStream.listen(
                            (scanData) async {
                              if (scanData != null) {
                                Map<String, dynamic> responseBody =
                                    jsonDecode(scanData);
                                if (responseBody.containsKey("table_id") &&
                                    responseBody.containsKey("restaurant_id")) {
                                  ScanResponse scanResponse =
                                      ScanResponse.fromJson(responseBody);
                                  Functions().showLoadingDialog(context);
                                  try {
                                    ApiRequestModel apiRequestModel =
                                        await Provider.of<TabProvider>(context,
                                                listen: false)
                                            .createTab(scanResponse,
                                                widget.userAccount);
                                    if (apiRequestModel.isSuccessful) {
                                      TabModel tab = apiRequestModel.result;
                                      widget.userAccount.tab = tab;
                                      Provider.of<UserAccountProvider>(context,
                                              listen: false)
                                          .setCurrentUserTabs(tab);
                                      Navigator.pop(context);
                                      Functions().scaleToReplace(
                                          context,
                                          ScanSuccessful(
                                              userAccount: widget.userAccount),
                                          removePreviousRoots: true);
                                    } else {
                                      Navigator.pop(context);
                                      showInSnackBar(
                                          apiRequestModel.errorMessage);
                                    }
                                  } catch (e) {
                                    print(e);
                                    Navigator.pop(context);
                                    showInSnackBar("Internal Error");
                                  }
                                }
                              }
                            },
                          );
                        },
                        overlay: QrScannerOverlayShape(
                          borderColor: CustomColors.primary,
                          borderRadius: 10,
                          borderLength: 15,
                          borderWidth: 10,
                          cutOutSize: 130,
                        ),
                      );
                    });
                  },
                )),
            SizedBox(height: 40),
            Container(
              width: screenSize.width,
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                "Enter a Group code to join someone's Tab",
                style: TextStyle(
                  color: Color(0xffF2F2F9),
                  letterSpacing: 1,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
                alignment: Alignment.center,
                width: screenSize.width,
                child: TextField(
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 4.3,
                      color: Color(0xFFF2F2F9)),
                  controller: textEditingController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE5C27A),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE5C27A),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 18, top: 10),
                    hintText: "Group Code",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: IconButton(
                        onPressed: () {
                          if (textEditingController.text.length > 0) {
                            _handleSubmitted(textEditingController.text);
                          }
                        },
                        icon: Icon(
                          NuvleIcons.icon_right,
                          size: 15,
                          color: Color(0xffE5C27A),
                        ),
                      ),
                    ),
                  ),
                )),
            SizedBox(height: 30),
            FlatButton(
              onPressed: () =>
                  Functions.openBottomSheet(context, LearnGroupCode(), true),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "How does group code work?",
                    style: TextStyle(
                      fontSize: 15,
                      color: CustomColors.primary100,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: 15, color: CustomColors.primary100)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
