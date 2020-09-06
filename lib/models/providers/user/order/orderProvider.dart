import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuvlemobile/api/apiRequests.dart';
import 'package:nuvlemobile/misc/validations.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/menus/menuData.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';

class OrderProvider extends ChangeNotifier {
  List<MenuItems> _viewedItems = [];
  bool _showOrderList = false;
  List<MenuItems> _orders = [];
  List<MenuItems> _tab = List<MenuItems>();
  List<List<dynamic>> _history = List<List<dynamic>>();
  List<MenuItems> _feedbackList = List<MenuItems>();
  ScrollController scrollController = ScrollController();
  double _bill = 0;

  List<MenuItems> get viewedItems => _viewedItems;
  bool get showOrderList => _showOrderList;
  List<MenuItems> get orders => _orders;
  List<MenuItems> get tab => _tab;
  List<List<dynamic>> get history => _history;
  List<MenuItems> get feedbackList => _feedbackList;
  double get bill => _bill;

  bool isAddedToOrder(MenuItems val) =>
      _orders.indexWhere((e) => val.itemId == e.itemId) != -1;

  set showOrderList(bool val) {
    _showOrderList = val;
    notifyListeners();
  }

  getBill(double val) {
    _bill = val;
  }

  addOrder(MenuItems val) {
    _orders.add(val);
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
    notifyListeners();
  }

  closeTab() {
    _tab.forEach((element) {
      _history
          .add([element, DateFormat.yMMMd().format(DateTime.now()).toString()]);
    });
    _feedbackList.addAll(_tab);
    _tab.clear();
  }

  feedback() {
    _feedbackList.clear();
  }

  removeOrder(MenuItems val) {
    int index = _orders.indexWhere((e) => val.itemId == e.itemId);
    if (index != -1) {
      _orders.removeAt(index);
      notifyListeners();
    }
  }

  MenuItems getSingleItem(MenuItems menuItem) {
    int i = _viewedItems.indexWhere((e) => e.itemId == menuItem.itemId);
    if (i != -1) {
      return _viewedItems[i];
    } else {
      return menuItem;
    }
  }

  addSelectedSide(MenuItems menuItem, MenuItems side) {
    int i = _viewedItems.indexWhere((e) => e.itemId == menuItem.itemId);
    if (i != -1) {
      if (_viewedItems[i].selectedSides != null) {
        _viewedItems[i].selectedSides.add(side);
      } else {
        _viewedItems[i].selectedSides = [side];
      }
    } else {
      menuItem.selectedSides = [side];
      _viewedItems.add(menuItem);
    }
    notifyListeners();
  }

  removeSelectedSide(MenuItems menuItem, MenuItems side) {
    int i = _viewedItems.indexWhere((e) => e.itemId == menuItem.itemId);
    if (i != -1 && _viewedItems[i].selectedSides != null) {
      _viewedItems[i].selectedSides.removeWhere((e) => e.itemId == side.itemId);
    }
    notifyListeners();
  }

  confirmedSideSelection(MenuItems menuItem) {
    int i = _viewedItems.indexWhere((e) => e.itemId == menuItem.itemId);
    if (i != -1) {
      _viewedItems[i].confirmedSides = _viewedItems[i].selectedSides;
    }
    notifyListeners();
  }

  changeCookingPreference(MenuItems menuItem, String cookingPref) {
    int i = _viewedItems.indexWhere((e) => e.itemId == menuItem.itemId);
    if (i != -1) {
      _viewedItems[i].selectedCookingPreference = cookingPref;
    } else {
      menuItem.selectedCookingPreference = cookingPref;
      _viewedItems.add(menuItem);
    }
    notifyListeners();
  }

  isTakeAway(MenuItems menuItem, [bool value = false]) {
    int i = _viewedItems.indexWhere((e) => e.itemId == menuItem.itemId);
    if (i != -1) {
      _viewedItems[i].takeAway = value;
      notifyListeners();
    } else {
      menuItem.takeAway = value;
      _viewedItems.add(menuItem);
    }
  }

  rateOrder(MenuItems menuItem, double value) {
    int i = _viewedItems.indexWhere((e) => e.itemId == menuItem.itemId);
    if (i != -1) {
      MenuItems item = _viewedItems[i];
      item.rating = value;
    } else {
      menuItem.rating = value;
      _viewedItems.add(menuItem);
    }
    notifyListeners();
  }

  changeOrderQuantity(MenuItems menuItem, [bool increment = true]) {
    int i = _viewedItems.indexWhere((e) => e.itemId == menuItem.itemId);
    if (i != -1) {
      MenuItems item = _viewedItems[i];
      if (increment)
        item.orderQuantity++;
      else {
        if (item.orderQuantity > 1) {
          item.orderQuantity--;
        }
      }
    } else {
      menuItem.orderQuantity++;
      _viewedItems.add(menuItem);
    }
    notifyListeners();
  }

  saveOrderNote(String note, MenuItems menuItem) {
    int i = _viewedItems.indexWhere((e) => e.itemId == menuItem.itemId);
    if (i != -1) {
      MenuItems item = _viewedItems[i];
      item.note = note;
    } else {
      menuItem.note = note;
      _viewedItems.add(menuItem);
    }
    notifyListeners();
  }

  Future<ApiRequestModel> order(UserAccount account,
      [List<MenuItems> items]) async {
    ApiRequestModel apiRequestModel = ApiRequestModel();
    Map<String, dynamic> body = {
      "tab_id": account.tab.attributes.id,
      "orders": items.map((e) {
        Map<String, dynamic> res = {
          "item_id": e.itemId,
          "item_type": e.itemType,
          "note": e.note ?? "empty"
        };
        if (e.confirmedSides != null) {
          res.addAll({
            "side_dishes_id": e.confirmedSides.map((e) => e.itemId).toList()
          });
        }
        if (e.selectedCookingPreference != null) {
          res.addAll({
            "cooking_preferences": [e.selectedCookingPreference]
          });
        }
        return res;
      }).toList(),
    };
    print(body);
    try {
      var responseBody = await ApiRequest.postJSON(
          body, "${account.tab.attributes.restaurantId}/orders", account.token);
      print(responseBody);
      if (responseBody["success"]) {
        // OrderModel order = OrderModel.fromJson(responseBody["data"]);
        apiRequestModel.isSuccessful = true;
        _tab.addAll(items);
        _orders.clear();
        // apiRequestModel.result = order;
        notifyListeners();
      } else {
        apiRequestModel = Validations()
            .getErrorMessage(responseBody['message'], responseBody['data']);
      }
    } catch (e) {
      print("EERRRRR $e");
      apiRequestModel.isSuccessful = false;
      apiRequestModel.errorMessage = "Internal error, please try again";
    }
    return apiRequestModel;
  }
}
