import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Nuvle/api/apiRequests.dart';
import 'package:Nuvle/misc/validations.dart';
import 'package:Nuvle/models/providers/socket/socket_provider.dart';
import 'package:Nuvle/models/skeltons/api/apiRequestModel.dart';
import 'package:Nuvle/models/skeltons/menus/menuData.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:provider/provider.dart';

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

  set orderList(List userTab) {
    _tab = userTab
        .map(
          (e) => MenuItems(
            isFree: e['markAsFree'],
            price: e['item_id']['price'],
            itemName: e['item_id']['item_name'],
            discount: e['discount'] == null ? null : int.parse(e['discount']),
            imageUrl: e['item_id']['image_url'],
            currency: e['item_id']['currency'],
            itemType: e['item_id']['_cls'],
          ),
        )
        .toList();
    // print(_tab[0].itemType);
    notifyListeners();
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
    // _feedbackList.forEach((element) {
    //   element.rating = 5;
    // });
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

  Future<ApiRequestModel> order(UserAccount account, BuildContext context,
      [List<MenuItems> items]) async {
    SocketProvider provider =
        Provider.of<SocketProvider>(context, listen: false);
    ApiRequestModel apiRequestModel = ApiRequestModel();
    List<Map<String, dynamic>> list = items
        .map((e) => {
              "restaurant_id": account.tab.attributes.restaurantId,
              "tab": account.tab.attributes.id,
              "side_dishes_ids": e.selectedSides != null
                  ? e.selectedSides.map((e) => e.itemId).toList()
                  : [],
              "item_id": e.itemId,
              "amount": e.price,
              "note": e.note,
              "quantity": e.orderQuantity,
              "toGo": e.takeAway,
              "user": account.tab.attributes.user.attributes.id,
              "cooking_preferences": e.selectedCookingPreference
            })
        .toList();

    // Map<String, dynamic> body = {
    //   "tab_id": account.tab.attributes.id,
    //   "orders": items.map((e) {
    //     Map<String, dynamic> res = {
    //       "item_id": e.itemId,
    //       "item_type": e.itemType,
    //       "note": e.note ?? "empty"
    //     };
    //     if (e.confirmedSides != null) {
    //       res.addAll({
    //         "side_dishes_id": e.confirmedSides.map((e) => e.itemId).toList()
    //       });
    //     }
    //     if (e.selectedCookingPreference != null) {
    //       res.addAll({
    //         "cooking_preferences": [e.selectedCookingPreference]
    //       });
    //     }
    //     return res;
    //   }).toList(),
    // };
    // print(body);
    try {
      list.length > 1
          ? provider.placeMultipleOrders({"orders": list})
          : provider.placeOrder(list[0]);
      apiRequestModel.isSuccessful = true;
      _tab.addAll(items);
      _orders.clear();
      notifyListeners();
    } catch (e) {
      print("EERRRRR $e");
      apiRequestModel.isSuccessful = false;
      apiRequestModel.errorMessage = "Internal error, please try again";
    }
    return apiRequestModel;
  }
}
