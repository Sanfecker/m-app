import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:geocoder/geocoder.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/components/widgets/user/myTab/payment/payBottomSheet.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/settings.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/providers/user/userAccountProvider.dart';
import 'package:nuvlemobile/models/skeltons/menus/menuData.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:nuvlemobile/pages/user/main/menus/myTab/payment/paymentComplete.dart';
import 'package:nuvlemobile/payment/paystack/paystack.dart';
import 'package:nuvlemobile/payment/stripe/stripe.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CloseTabBottomSheet extends StatefulWidget {
  final List<MenuItems> tab;
  final UserAccount userAccount;

  const CloseTabBottomSheet({Key key, @required this.tab, this.userAccount})
      : super(key: key);
  @override
  _CloseTabBottomSheetState createState() => _CloseTabBottomSheetState();
}

class _CloseTabBottomSheetState extends State<CloseTabBottomSheet> {
  String _selectedTip = "No Tip";
  TextEditingController controller = TextEditingController();

  _handleCheckout(int bill, BuildContext context) async {
    Charge charge = Charge()
      ..amount = bill // In base currency
      ..email = widget.userAccount.attributes.email;
    // ..card = _getCardFromUI();
    // Functions().navigateTo(context, Paystack());
    charge.reference = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      CheckoutResponse response = await PaystackPlugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
        logo: Image.asset(
          Settings.placeholderImageSmall,
          height: 50,
          width: 50,
        ),
      );
      print('Response = $response');
      if (response.message == 'Success') {
        Functions().navigateTo(context, PaymentComplete());
      }
    } catch (e) {
      print(e);
    }
  }

  payWithNewCard() async {
    var paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest());
    // var paymentIntent = await Stripe
  }

  double total() {
    OrderProvider _orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    double result = 0;
    widget.tab.forEach((element) {
      result += int.parse(element.price);
    });
    if (_selectedTip != "No Tip") {
      result += (result * int.parse(_selectedTip) / 100);
    }
    if (controller.text.isNotEmpty && controller.text != null) {
      result += int.parse(controller.text);
    }
    _orderProvider.getBill(result);
    return result;
  }

  String location;
  bool getLocation() {
    checkPermission().then((value) {
      if (value == LocationPermission.denied) {
        requestPermission();
      }
    });
    try {
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((value) async {
        List<Address> placemark = await Geocoder.local
            .findAddressesFromCoordinates(
                Coordinates(value.latitude, value.longitude));

        location = placemark[0].countryName;
        print(location);
      });
    } catch (e) {
      print(e);
    }
    return location == 'Nigeria';
  }

  @override
  void initState() {
    getLocation()
        ? PaystackPlugin.initialize(publicKey: paystackPublicKey)
        : StripePayment.setOptions(StripeOptions(
            publishableKey:
                "pk_test_51HBKGCAEqZIazashJa8IJ1IRT8j7m8CdmfuomZGRUCEF7lHjt2HltE4nem5GkiFhaWm3F79eDXr75U6un9mmy0Dg00ZaLbhqv7",
            merchantId: "Test",
            androidPayMode: 'test'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 3,
            width: 68,
            decoration: BoxDecoration(
              color: Color(0xffF2F2F9).withOpacity(0.4),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Close Tab",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: CustomColors.primary100,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 30,
                    color: CustomColors.primary100,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(
                      'Add a Tip',
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomColors.primary100,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 17),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: ["No Tip", "10", "15", "20"]
                                .map(
                                  (e) => Container(
                                    height: 68,
                                    width: 75,
                                    child: _selectedTip == e
                                        ? FlatButton(
                                            onPressed: () => setState(() {
                                              _selectedTip = e;
                                              if (e != 'No Tip') {
                                                controller.clear();
                                              }
                                            }),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4),
                                            color: Color(0xffD4B471),
                                            child: Text(
                                              '${_selectedTip == 'No Tip' ? e : e + '\%'}',
                                              style: TextStyle(
                                                letterSpacing: 0.3,
                                                fontSize: 16,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          )
                                        : OutlineButton(
                                            onPressed: () => setState(() {
                                              _selectedTip = e;
                                              if (e != 'No Tip') {
                                                controller.clear();
                                              }
                                            }),
                                            color: Color(0xffD4B471),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Text(
                                              '${e == 'No Tip' ? e : e + '\%'}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 0.3,
                                                fontSize: 16,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xffD4B471),
                                            ),
                                          ),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 55),
                    Text(
                      'Custom Amount',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.3,
                      ),
                    ),
                    InputBox(
                      controller: controller,
                      bottomMargin: 25,
                      hintText: "Enter custom amount...",
                      textStyle: TextStyle(
                        fontSize: 24,
                        letterSpacing: -0.28,
                        color: Color(0xffF2F2F9),
                      ),
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onSaved: (String val) {},
                      onChange: (a) => setState(() {
                        _selectedTip = 'No Tip';
                      }),
                      contentPadding: EdgeInsets.zero,
                      enabledBorderColor: Colors.white,
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.primary100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '\$${total().toString()}',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'includes both taxes and tip (\$17)',
                                style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Consumer<UserAccountProvider>(
                builder: (context, pro, child) => Functions().customButton(
                  context,
                  // onTap: () => Functions.openBottomSheet(
                  //     context,
                  //     PayBottomSheet(
                  //         amount: total(), userAccount: widget.userAccount),
                  //     true),
                  onTap: () {
                    if (getLocation()) {
                      _handleCheckout((total() * 100).round(), context);
                    } else {
                      StripePayment.paymentRequestWithNativePay(
                        androidPayOptions: AndroidPayPaymentRequest(
                          totalPrice: "${total() * 100}",
                          currencyCode: getLocation() ? 'NGN' : 'USD',
                        ),
                        applePayOptions: ApplePayPaymentOptions(
                          countryCode: getLocation() ? 'NG' : 'US',
                          currencyCode: getLocation() ? 'NGN' : 'USD',
                          items: [
                            ApplePayItem(
                              // label: 'Test',
                              amount: "${total() * 100}",
                            )
                          ],
                        ),
                      );
                    }
                  },
                  width: screenSize.width,
                  text: "Pay",
                  specificBorderRadius: BorderRadius.circular(5),
                  hasIcon: true,
                  trailing: Icon(
                    NuvleIcons.icon_right,
                    color: Color(0xff474551),
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
