import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuvlemobile/pages/user/main/menus/editOrderDetails.dart';
import 'package:nuvlemobile/pages/user/main/menus/orderItem.dart';
import 'package:nuvlemobile/styles/colors.dart';
import 'package:nuvlemobile/styles/nuvleIcons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/misc/settings.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';

import 'orderComplete.dart';

class OrderPage extends StatelessWidget {
  final UserAccount userAccount;
  const OrderPage({
    Key key,
    this.userAccount,
  }) : super(key: key);
  _handleSubmitted(BuildContext ctx) async {
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(ctx, listen: false);
    bool selectionComplete() {
      return orderProvider.orders.every((element) {
        if (element.cookingPreferences != null &&
                element.selectedCookingPreference == null &&
                element.cookingPreferences.any((element) {
                  if (element != '')
                    return true;
                  else
                    return false;
                }) ||
            element.note == null)
          return false;
        else
          return true;
      });
    }

    print(selectionComplete());

    if (selectionComplete()) {
      Functions().showLoadingDialog(ctx);
      try {
        ApiRequestModel apiRequestModel =
            await orderProvider.order(userAccount, orderProvider.orders);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              SizedBox(
                width: 14,
              ),
              Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xffe5c27a),
                size: 25,
              ),
              // Spacer(),
              Text(
                'Back',
                style: TextStyle(
                  color: Color(0xffe5c27a),
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              )
            ],
          ),
        ),
        elevation: 0,
        leadingWidth: 74,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 17,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Order',
              style: TextStyle(
                color: Color(0xfff2f2f9),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<OrderProvider>(
                builder: (context, pro, child) => ListView(
                  controller: pro.scrollController,
                  shrinkWrap: true,
                  children: pro.orders.map((e) {
                    return GestureDetector(
                      onTap: () => Functions().scaleTo(
                        context,
                        EditOrderDetails(menuItem: e, userAccount: userAccount),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 20,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xff363a47),
                            borderRadius: BorderRadius.circular(14),
                            border: e.cookingPreferences != null &&
                                        e.selectedCookingPreference == null &&
                                        e.cookingPreferences.any((element) {
                                          return element != '';
                                        }) ||
                                    e.note == null
                                ? Border.all(
                                    color: Colors.red,
                                    width: 2,
                                  )
                                : null),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: e.imageUrl ?? '',
                              width: 60,
                              height: 60,
                              errorWidget: (context, url, error) => Image.asset(
                                Settings.placeholderImageSmall,
                                width: 65,
                                height: 63,
                              ),
                              placeholder: (BuildContext context, String val) {
                                return Image.asset(
                                  Settings.placeholderImageSmall,
                                  width: 65,
                                  height: 63,
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.itemName.toLowerCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '${Functions.getCurrencySymbol(e.currency)}${e.price}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xffd2b271),
                              size: 24,
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Functions().customButton(
              context,
              onTap: () => _handleSubmitted(context),
              width: MediaQuery.of(context).size.width * 0.9,
              text: "Send Order",
              color: CustomColors.primary900,
              hasIcon: true,
              trailing: Icon(
                NuvleIcons.icon_right,
                color: Color(0xff474551),
              ),
            ),
            SizedBox(
              height: 37,
            ),
          ],
        ),
      ),
    );
  }
}
