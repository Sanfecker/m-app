import 'package:flutter/material.dart';
import 'package:Nuvle/api/apiRequests.dart';
import 'package:Nuvle/misc/enum.dart';
import 'package:Nuvle/misc/validations.dart';
import 'package:Nuvle/models/providers/user/userAccountProvider.dart';
import 'package:Nuvle/models/skeltons/menus/menuData.dart';
import 'package:Nuvle/models/skeltons/menus/restaurantMenuType.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:provider/provider.dart';

class MenusProvider extends ChangeNotifier {
  List<MenuData> _menuData = [];
  APIRequestStatus _apiRequestStatus = APIRequestStatus.unInitialized,
      _moreAPIRequestStatus = APIRequestStatus.unInitialized;

  APIRequestStatus get apiRequestStatus => _apiRequestStatus;
  APIRequestStatus get moreAPIRequestStatus => _moreAPIRequestStatus;

  List<MenuItems> fetchMenuItems(MenuType type) {
    int index = _menuData.indexWhere((e) => e.menuType == type.menuType);
    return index != -1 ? _menuData[index].menuItems : [];
  }

  updateAPIRequestStatus(APIRequestStatus status) {
    _apiRequestStatus = status;
    notifyListeners();
  }

  setState() {
    notifyListeners();
  }

  getPage(MenuType type) {
    int index = _menuData.indexWhere((e) => e.menuType == type.menuType);
    if (index != -1) {
      return _menuData[index].hasNextPage;
    }
    return false;
  }

  updateMoreAPIRequestStatus(APIRequestStatus status) {
    _moreAPIRequestStatus = status;
    notifyListeners();
  }

  fetchMenus(
      BuildContext context, MenuType type, UserAccount userAccount) async {
    int index = _menuData.indexWhere((e) => e.menuType == type.menuType);
    if (index != -1 &&
        _menuData[index].menuItems != null &&
        _menuData[index].menuItems.length > 0) {
      updateAPIRequestStatus(APIRequestStatus.loaded);
    } else {
      updateAPIRequestStatus(APIRequestStatus.loading);
    }
    try {
      var responseBody = await ApiRequest.get(
          "${type.restaurantId}/menus/${type.menuType}?page=1",
          userAccount.token);
      if (responseBody["success"]) {
        MenuData temp = MenuData.fromJson(responseBody['data'], type.menuType);
        if (index == -1) {
          _menuData.add(temp);
        } else {
          temp.menuItems.map((v) {
            int i = _menuData[index]
                .menuItems
                .indexWhere((each) => each.itemId == v.itemId);
            if (i == -1) {
              _menuData[index].menuItems.add(v);
            } else {
              _menuData[index].menuItems[i] = v;
            }
          }).toList();
        }
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

  fetchMoreMenus(BuildContext context, MenuType type, UserAccount userAccount,
      String page) async {
    int index = _menuData.indexWhere((e) => e.menuType == type.menuType);
    if (page == 'next') {
      if (_menuData[index].nextPage != null) {
        updateMoreAPIRequestStatus(APIRequestStatus.loading);
        try {
          var responseBody = await ApiRequest.get(
              "${type.restaurantId}/menus/${type.menuType}?page=${_menuData[index].nextPage}",
              userAccount.token);
          if (responseBody["success"]) {
            MenuData temp =
                MenuData.fromJson(responseBody['data'], type.menuType);
            if (_menuData[index].nextPage == null) {
              _menuData[index] = temp;
            } else {
              _menuData[index].nextPage = temp.nextPage;
              temp.menuItems.map((v) {
                int i = _menuData[index]
                    .menuItems
                    .indexWhere((each) => each.itemId == v.itemId);
                if (i == -1) {
                  _menuData[index].menuItems.add(v);
                } else {
                  _menuData[index].menuItems[i] = v;
                }
              }).toList();
            }
            updateMoreAPIRequestStatus(APIRequestStatus.loaded);
          } else {
            APIRequestStatus apiRequestStatus = Validations().getAPIErrorType(
                responseBody["message"] ?? responseBody["data"]);
            if (apiRequestStatus == APIRequestStatus.unauthorized) {
              Provider.of<UserAccountProvider>(context, listen: false)
                  .logoutCurrentUser(context);
            } else {
              updateMoreAPIRequestStatus(apiRequestStatus);
            }
          }
        } catch (e) {
          print("efEERRRRR $e");
          updateMoreAPIRequestStatus(APIRequestStatus.error);
        }
      } else if (page == 'previous') {
        if (_menuData[index].hasPreviousPage) {
          updateMoreAPIRequestStatus(APIRequestStatus.loading);
          try {
            var responseBody = await ApiRequest.get(
                "${type.restaurantId}/menus/${type.menuType}?page=${_menuData[index].previousPage}",
                userAccount.token);
            if (responseBody["success"]) {
              MenuData temp =
                  MenuData.fromJson(responseBody['data'], type.menuType);
              if (!_menuData[index].hasPreviousPage) {
                _menuData[index] = temp;
              } else {
                _menuData[index].previousPage = temp.previousPage;
                temp.menuItems.map((v) {
                  int i = _menuData[index]
                      .menuItems
                      .indexWhere((each) => each.itemId == v.itemId);
                  if (i == -1) {
                    _menuData[index].menuItems.add(v);
                  } else {
                    _menuData[index].menuItems[i] = v;
                  }
                }).toList();
              }
              updateMoreAPIRequestStatus(APIRequestStatus.loaded);
            } else {
              APIRequestStatus apiRequestStatus = Validations().getAPIErrorType(
                  responseBody["message"] ?? responseBody["data"]);
              if (apiRequestStatus == APIRequestStatus.unauthorized) {
                Provider.of<UserAccountProvider>(context, listen: false)
                    .logoutCurrentUser(context);
              } else {
                updateMoreAPIRequestStatus(apiRequestStatus);
              }
            }
          } catch (e) {
            print("efEERRRRR $e");
            updateMoreAPIRequestStatus(APIRequestStatus.error);
          }
        }
      }
    }
  }
}
