// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:nuvlemobile/components/inputs/pinInputBox.dart';
// import 'package:nuvlemobile/misc/functions.dart';
// import 'package:nuvlemobile/models/providers/user/tabProvider.dart';
// import 'package:nuvlemobile/models/providers/user/userAccountProvider.dart';
// import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
// import 'package:nuvlemobile/models/skeltons/user/tab.dart';
// import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
// import 'package:nuvlemobile/pages/user/scan/learnGroupCode.dart';
// import 'package:nuvlemobile/pages/user/scan/scanSuccessful.dart';
// import 'package:nuvlemobile/styles/colors.dart';
// import 'package:provider/provider.dart';

// class GroupCodeBottomSheet extends StatefulWidget {
//   final UserAccount userAccount;

//   const GroupCodeBottomSheet({Key key, @required this.userAccount})
//       : super(key: key);
//   @override
//   _GroupCodeBottomSheetState createState() => _GroupCodeBottomSheetState();
// }

// class _GroupCodeBottomSheetState extends State<GroupCodeBottomSheet> {
//   TextEditingController textEditingController = TextEditingController();

//   _handleSubmitted(String code) async {
//     Functions().showLoadingDialog(context);
//     try {
//       ApiRequestModel apiRequestModel =
//           await Provider.of<TabProvider>(context, listen: false)
//               .joinTabByCode(code, widget.userAccount);
//       if (apiRequestModel.isSuccessful) {
//         TabModel tab = apiRequestModel.result;
//         widget.userAccount.tab = tab;
//         Provider.of<UserAccountProvider>(context, listen: false)
//             .setCurrentUserTabs(tab);
//         Navigator.pop(context);
//         Functions().transitToReplace(
//             context, ScanSuccessfulPage(userAccount: widget.userAccount),
//             removePreviousRoots: true);
//       } else {
//         Navigator.pop(context);
//         await Fluttertoast.showToast(
//           msg: apiRequestModel.errorMessage,
//           textColor: Colors.black,
//           backgroundColor: CustomColors.primary,
//         );
//       }
//     } catch (e) {
//       print(e);
//       Navigator.pop(context);
//       await Fluttertoast.showToast(
//         msg: "Internal Error",
//         textColor: Colors.black,
//         backgroundColor: CustomColors.primary,
//       );
//     }
//   }

//   @override
//   void dispose() {
//     textEditingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Padding(
//       padding: MediaQuery.of(context).viewInsets,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 10),
//             height: 3,
//             width: 68,
//             decoration: BoxDecoration(
//               color: Color(0xffF2F2F9).withOpacity(0.4),
//               borderRadius: BorderRadius.circular(5),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       "Group Code",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25,
//                         color: CustomColors.primary100,
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         Icons.close,
//                         size: 30,
//                         color: CustomColors.primary100,
//                       ),
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                   ],
//                 ),
//                 PinInput(
//                   controller: textEditingController,
//                   autofocus: false,
//                   maxLength: 6,
//                   highlight: true,
//                   highlightColor: CustomColors.primary,
//                   pinBoxWidth: 40,
//                   defaultBorderColor:
//                       Theme.of(context).primaryColor.withOpacity(0.6),
//                   hasTextBorderColor: CustomColors.primary,
//                   hasError: false,
//                   wrapAlignment: WrapAlignment.center,
//                   // onDone: (text) => _handleSubmitted(text),
//                   pinBoxDecoration:
//                       ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
//                   pinTextStyle: TextStyle(fontSize: 24),
//                   pinTextAnimatedSwitcherTransition:
//                       ProvidedPinBoxTextAnimation.scalingTransition,
//                   pinTextAnimatedSwitcherDuration: Duration(milliseconds: 100),
//                   keyboardType: TextInputType.number,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(vertical: 40),
//                   child: FlatButton(
//                     onPressed: () => Functions.openBottomSheet(
//                         context, LearnGroupCode(), true),
//                     child: Text(
//                       "How it works?",
//                       style: TextStyle(
//                         letterSpacing: -0.28,
//                         fontSize: 16,
//                         color: CustomColors.primary100,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Functions().customButton(
//             context,
//             onTap: () => textEditingController.text.length > 0
//                 ? _handleSubmitted(textEditingController.text)
//                 : null,
//             width: screenSize.width,
//             text: "Apply",
//             specificBorderRadius: BorderRadius.only(
//               topLeft: Radius.circular(5),
//               topRight: Radius.circular(5),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
