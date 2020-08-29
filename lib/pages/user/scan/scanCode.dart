import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  const ScanCodePage({Key key, @required this.userAccount}) : super(key: key);
  @override
  _ScanCodePageState createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  
TextEditingController textEditingController = TextEditingController();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

   _buttomenuSubmitted(BuildContext ctx) async {
    Functions().showLoadingDialog(ctx);
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(ctx, listen: false);
    try {
      ApiRequestModel apiRequestModel =
          await orderProvider.order(widget.userAccount, orderProvider.orders);
      if (apiRequestModel.isSuccessful) {
        Navigator.pop(ctx);
        Functions()
            .transitTo(ctx, OrderComplete(), PageTransitionType.downToUp);
      } else {
        Navigator.pop(ctx);
        await Fluttertoast.showToast(
          msg: apiRequestModel.errorMessage,
        );
      }
    } catch (e) {
      Navigator.pop(ctx);
      await Fluttertoast.showToast(
        msg: "Internal Error",
      );
    }
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(elevation: 0),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Consumer2<MainPageProvider, OrderProvider>(
        builder: (context, pro, pro2, child) => pro2.showOrderList &&
                pro2.orders.length > 0
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 30,
                        color: CustomColors.primary100,
                      ),
                      onPressed: () => pro2.showOrderList = false,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: 70,
                        margin: EdgeInsets.only(right: 10),
                        child: Consumer<OrderProvider>(
                          builder: (context, pro, child) => ListView(
                            controller: pro.scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: pro.orders
                                .map(
                                  (e) => Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl: e.imageUrl ?? '',
                                            width: 65,
                                            height: 63,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              Settings.placeholderImageSmall,
                                              width: 65,
                                              height: 63,
                                            ),
                                            placeholder: (BuildContext context,
                                                String val) {
                                              return Image.asset(
                                                Settings.placeholderImageSmall,
                                                width: 65,
                                                height: 63,
                                              );
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: -3,
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            child: FlatButton(
                                              color: CustomColors.primary100,
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              onPressed: () =>
                                                  pro.removeOrder(e),
                                              child: Icon(
                                                Icons.close,
                                                color: CustomColors.licoRice,
                                                size: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () => _buttomenuSubmitted(context),
                      child: Text(
                        "Order",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      shape: StadiumBorder(),
                      color: CustomColors.primary100,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color(0xff263238),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    )),
              )
            : Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: pro.tabIcons.map((e) {
                    int i = pro.tabIcons.indexOf(e);
                    return i == pro.selectedIndex
                        ? FloatingActionButton(
                            heroTag: ObjectKey("bnv_$i"),
                            onPressed: () => pro.selectedIndex = i,
                            child: Icon(e),
                            backgroundColor: CustomColors.primary100,
                          )
                        : IconButton(
                            icon: Icon(
                              e,
                              color: Color(0xff828282),
                            ),
                            onPressed: () => pro.selectedIndex = i,
                          );
                  }).toList(),
                ),
              ),
      ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                // margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.60,
                      height: screenSize.width * 0.15,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("Nice to see you,",
                              style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 23)
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("${widget.userAccount.attributes.firstname}.",
                              style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21, color: CustomColors.primary)
                              )
                            ],
                          )
                        ],
                      )
                      
                    
                    ),
                    Center(
                      child: Container(
                        width: screenSize.width * 0.80,
                        margin: EdgeInsets.only(bottom: 12),
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
                height: 150,
                width: screenSize.width,
                child: QRView(
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
                              ApiRequestModel apiRequestModel = await Provider
                                      .of<TabProvider>(context, listen: false)
                                  .createTab(scanResponse, widget.userAccount);
                              if (apiRequestModel.isSuccessful) {
                                TabModel tab = apiRequestModel.result;
                                widget.userAccount.tab = tab;
                                Provider.of<UserAccountProvider>(context,
                                        listen: false)
                                    .setCurrentUserTabs(tab);
                                Navigator.pop(context);
                                Functions().scaleToReplace(context,
                                    ScanSuccessful(userAccount: widget.userAccount),
                                    removePreviousRoots: true);
                              } else {
                                Navigator.pop(context);
                                showInSnackBar(apiRequestModel.errorMessage);
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
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: screenSize.width,
                padding: const EdgeInsets.only(left: 7),
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
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: screenSize.width,
                child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                hintText: "Group Code",
                contentPadding: EdgeInsets.only(left: 7, right: 25),
                suffixIcon: IconButton(
                  onPressed: (){
                  textEditingController.text.length > 0
                  ? _handleSubmitted(textEditingController.text)
                  : null;
                  },
                  icon: Icon(
                    NuvleIcons.icon_right,
                    size: 15,
                    color: Color(0xffE5C27A),
                    ),
                  ),
                ),
              )
                
              
              ),
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
