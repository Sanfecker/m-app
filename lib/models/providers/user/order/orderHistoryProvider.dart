import 'package:flutter/material.dart';
import 'package:nuvlemobile/api/apiRequests.dart';
import 'package:nuvlemobile/misc/enum.dart';
import 'package:nuvlemobile/misc/validations.dart';
import 'package:nuvlemobile/models/providers/user/userAccountProvider.dart';
import 'package:nuvlemobile/models/skeltons/user/order.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:provider/provider.dart';

class OrderHistoryProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];
  APIRequestStatus _apiRequestStatus = APIRequestStatus.unInitialized;

  List<OrderModel> get orders => _orders;
  APIRequestStatus get apiRequestStatus => _apiRequestStatus;

  updateAPIRequestStatus(APIRequestStatus status) {
    _apiRequestStatus = status;
    notifyListeners();
  }

  fetchMenus(BuildContext context, UserAccount userAccount) async {
    if (_orders.length > 0) {
      updateAPIRequestStatus(APIRequestStatus.loaded);
    } else {
      updateAPIRequestStatus(APIRequestStatus.loading);
    }
    try {
      var responseBody = await ApiRequest.get(
          "${userAccount.tab.attributes.restaurantId}/orders",
          userAccount.token);
      if (responseBody["success"]) {
        _orders = List<OrderModel>.from(
            responseBody['data'].map((e) => OrderModel.fromJson(e)).toList());
        updateAPIRequestStatus(APIRequestStatus.loaded);
      } else {
        APIRequestStatus apiRequestStatus = Validations()
            .getAPIErrorType(responseBody["message"] ?? responseBody["data"]);
        if (apiRequestStatus == APIRequestStatus.unauthorized) {
          Provider.of<UserAccountProvider>(context, listen: false)
              .logoutCurrentUser(context);
        } else {
          updateAPIRequestStatus(apiRequestStatus);
        }
      }
    } catch (e) {
      print("efEERRRRR $e");
      updateAPIRequestStatus(APIRequestStatus.error);
    }
  }
}
