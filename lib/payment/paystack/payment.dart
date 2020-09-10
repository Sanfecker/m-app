// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';

// List<int> price = [200, 400, 1000, 2000, 5000, 10000, 25000];
// int groupValue;
// String paystackPublicKey = 'pk_test_6ccbe1b17bece35a1056c5b4559cf332b70d71d1';
// const String appName = 'maleezea';

// class Payment extends StatefulWidget {
//   @override
//   _PaymentState createState() => _PaymentState();
// }

// class _PaymentState extends State<Payment> {
//   bool _inProgress = false;

//   @override
//   void initState() {
//     PaystackPlugin.initialize(publicKey: paystackPublicKey);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Builder(
//         builder: (context) => radioButtons(context),
//       ),
//     );
//   }

//   Widget radioButtons(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       children: <Widget>[
//             Text(
//               'Select the amount',
//               style: TextStyle(
//                 fontFamily: 'greycliff',
//                 fontSize: 24,
//                 color: color6,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ] +
//           price.map(
//             (index) {
//               return ListTile(
//                 leading: Radio(
//                   groupValue: groupValue,
//                   value: index,
//                   onChanged: (index) {
//                     setState(
//                       () {
//                         groupValue = index;
//                       },
//                     );
//                   },
//                 ),
//                 title: Text(
//                   'N ' + index.toString(),
//                 ),
//               );
//             },
//           ).toList() +
//           [
//             RaisedButton(
//               onPressed: () => _handleCheckout(context),
//               color: Colors.blueAccent,
//               textColor: Colors.white,
//               padding:
//                   const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
//               child: new Text(
//                 'CHECKOUT',
//                 style: const TextStyle(fontSize: 17.0),
//               ),
//             )
//           ],
//     );
//   }

//   PaymentCard _getCardFromUI() {
//     // Using just the must-required parameters.
//     return PaymentCard(
//       number: null,
//       cvc: null,
//       expiryMonth: null,
//       expiryYear: null,
//     );
//   }

//   _handleCheckout(BuildContext context) async {
//     setState(() => _inProgress = true);
//     Charge charge = Charge()
//       ..amount = groupValue * 100 // In base currency
//       ..email = user.email
//       ..card = _getCardFromUI();

//     charge.reference =
//         'ChargedFromAndroid_${DateTime.now().millisecondsSinceEpoch}';

//     try {
//       CheckoutResponse response = await PaystackPlugin.checkout(
//         context,
//         method: CheckoutMethod.card,
//         charge: charge,
//         fullscreen: true,
//         logo: Image.asset(
//           'images/logo.png',
//           width: 100,
//         ),
//       );
//       print('Response = $response');
//       if (response.message == 'Success') {
//         setState(() {
//           map['balance'] != null
//               ? map['balance'] += groupValue
//               : map['balance'] = groupValue;
//           Navigator.pop(context);
//         });
//       }
//       setState(() => _inProgress = false);
//     } catch (e) {
//       print(e);
//       setState(() => _inProgress = false);
//       Scaffold.of(context).showSnackBar(
//         SnackBar(
//           content: Text('There was an error'),
//         ),
//       );
//     }
//   }
// }
