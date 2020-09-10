// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:Nuvle/components/icons/callWaiterIcon.dart';
// import 'package:Nuvle/misc/functions.dart';
// import 'package:Nuvle/misc/settings.dart';
// import 'package:Nuvle/models/skeltons/menus/menuData.dart';
// import 'package:Nuvle/models/skeltons/user/userAccount.dart';
// import 'package:Nuvle/pages/user/main/menus/orderItem.dart';
// import 'package:Nuvle/styles/colors.dart';
// import 'package:Nuvle/styles/nuvleIcons.dart';
//
// class ItemInfo extends StatelessWidget {
//   final UserAccount userAccount;
//   final MenuItems menuItem;
//
//   const ItemInfo(
//       {Key key, @required this.userAccount, @required this.menuItem})
//       : super(key: key);
//
//   _handleSubmitted(BuildContext context) async {
//     Functions().transitTo(
//       context,
//       OrderItem(menuItem: menuItem, userAccount: userAccount),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         actions: <Widget>[
//           CallWaiterIcon(),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: menuItem.itemTags.length > 0
//                     ? MainAxisAlignment.spaceBetween
//                     : MainAxisAlignment.center,
//                 children: <Widget>[
//                   Column(
//                     children: menuItem.itemTags
//                         .map(
//                           (e) => Container(
//                             margin: EdgeInsets.only(bottom: 12),
//                             child: FlatButton(
//                               color: Color(0xff4A444A),
//                               child: Text(
//                                 e.tagName,
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               shape: StadiumBorder(),
//                               onPressed: () => print("Hey"),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                   CachedNetworkImage(
//                     imageUrl: menuItem.imageUrl ?? '',
//                     width: 215,
//                     height: 245,
//                     errorWidget: (context, url, error) => Container(
//                       child: Image.asset(
//                         Settings.placeholderImageSmall,
//                         width: 215,
//                         height: 245,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                       ),
//                     ),
//                     placeholder: (BuildContext context, String val) {
//                       return Container(
//                         child: Image.asset(
//                           Settings.placeholderImageSmall,
//                           width: 215,
//                           height: 245,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.transparent,
//                         ),
//                       );
//                     },
//                     fit: BoxFit.cover,
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 30),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Flexible(
//                       child: Container(
//                         margin: EdgeInsets.only(right: 14),
//                         child: Text(
//                           menuItem.itemName.toLowerCase(),
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       Functions.getCurrencySymbol(menuItem.currency) +
//                           menuItem.price,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25,
//                         color: Color(0xffF2F2F9),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Text(
//                 'Description',
//                 style: TextStyle(
//                     color: Color(0xffD4B472),
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18),
//               ),
//               SizedBox(height: 12),
//               Text(
//                 menuItem.description,
//                 style: TextStyle(letterSpacing: 1, fontSize: 14),
//               ),
//               SizedBox(height: 40),
//               if (menuItem.sides != null && menuItem.sides.isNotEmpty)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'Side Option',
//                       style: TextStyle(
//                         color: Color(0xffD4B472),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     GridView(
//                         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                           maxCrossAxisExtent: 125,
//                           childAspectRatio: 0.8,
//                           mainAxisSpacing: 14,
//                           crossAxisSpacing: 20,
//                         ),
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         children: menuItem.sides
//                             .map(
//                               (e) => Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(5),
//                                     child: CachedNetworkImage(
//                                       imageUrl: e.imageUrl ?? '',
//                                       height: 80,
//                                       width: 80,
//                                       errorWidget: (context, url, error) =>
//                                           Container(
//                                         child: Image.asset(
//                                           Settings.placeholderImageSmall,
//                                           height: 80,
//                                           width: 80,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Colors.transparent,
//                                         ),
//                                       ),
//                                       placeholder:
//                                           (BuildContext context, String val) {
//                                         return Container(
//                                           child: Image.asset(
//                                             Settings.placeholderImageSmall,
//                                             height: 80,
//                                             width: 80,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Colors.transparent,
//                                           ),
//                                         );
//                                       },
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text(
//                                     e.itemName,
//                                     style: TextStyle(
//                                       letterSpacing: 0.3,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     '${e.calorieCount} Kcal',
//                                     style: TextStyle(
//                                       letterSpacing: 0.3,
//                                       fontSize: 10,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                             .toList()),
//                   ],
//                 ),
//               SizedBox(height: 60),
//               Functions().customButton(
//                 context,
//                 onTap: () => _handleSubmitted(context),
//                 width: screenSize.width,
//                 text: "Order",
//                 color: CustomColors.primary900,
//                 hasIcon: true,
//                 trailing: Icon(
//                   NuvleIcons.icon_right,
//                   color: Color(0xff474551),
//                   size: 14,
//                 ),
//               ),
//               SizedBox(height: 60),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
