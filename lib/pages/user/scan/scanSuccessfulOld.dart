// import 'package:flutter/material.dart';
// import 'package:Nuvle/components/buttons/circledButtonWithArrow.dart';
// import 'package:Nuvle/misc/functions.dart';
// import 'package:Nuvle/pages/user/main/mainPage.dart';

// class ScanSuccessfulPageOld extends StatelessWidget {
//   final int pin;

//   const ScanSuccessfulPageOld({Key key, @required this.pin}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 alignment: Alignment.centerLeft,
//                 margin: EdgeInsets.only(bottom: 60),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       width: screenSize.width * 0.60,
//                       margin: EdgeInsets.only(bottom: 20),
//                       child: Text(
//                         "Scan Successful",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 30),
//                       ),
//                     ),
//                     Container(
//                       width: screenSize.width * 0.80,
//                       child: Text(
//                         "Welcome, enjoy your menu experience.",
//                         style: TextStyle(
//                           color: Color(0xffF2F2F9),
//                           letterSpacing: 1,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Image.asset(
//                 "assets/images/Rectangle 25.png",
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
//                 child: Column(
//                   children: <Widget>[
//                     Text(
//                       "Group Code",
//                       style: TextStyle(
//                         letterSpacing: 1,
//                         fontSize: 16,
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       "$pin",
//                       style: TextStyle(
//                         letterSpacing: 1,
//                         fontSize: 36,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               CircledButtonWithArrow(
//                 onPressed: () => Functions().scaleTo(context, MainPage()),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
