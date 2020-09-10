import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Nuvle/api/apiRequests.dart';
import 'package:Nuvle/misc/functions.dart';
import 'package:Nuvle/misc/strings.dart';
import 'package:Nuvle/misc/validations.dart';
import 'package:Nuvle/models/skeltons/api/apiRequestModel.dart';
import 'package:Nuvle/models/skeltons/user/tab.dart';
import 'package:Nuvle/models/skeltons/user/userAccount.dart';
import 'package:Nuvle/pages/auth/login/loginEmail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAccountProvider extends ChangeNotifier {
  UserAccount _currentUserAccount;

  UserAccount get currentUserAccount => _currentUserAccount;

  setHasSeenOnBoard() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(Strings.hasSeenOnBoardSPKey, true);
    } catch (e) {
      print("SHARE PRE $e");
    }
  }

  logoutCurrentUser(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(Strings.currentUserSPKey);
      Functions().transitToReplace(context, LoginEmailPage(),
          removePreviousRoots: true);
    } catch (e) {
      print("SHARE PRE $e");
    }
  }

  synchronizeCurrentUser(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String currentUserDetails = prefs.getString(Strings.currentUserSPKey);
      if (currentUserDetails != null) {
        _currentUserAccount =
            UserAccount.fromJson(jsonDecode(currentUserDetails));
        print(_currentUserAccount.attributes.firstname);
        notifyListeners();
        freshFetch();
      } else {
        Functions().scaleToReplace(context, LoginEmailPage(),
            removePreviousRoots: true);
      }
    } catch (e) {
      print("ERRRR $e");
    }
  }

  freshFetch() async {
    // try {
    //   String apiResponse =
    //       await ApiRequest.get("user/me", _currentUserAccount.token);
    //   var responseBody = jsonDecode(apiResponse);
    //   if (responseBody["success"]) {
    //     UserAccount temp = UserAccount.fromJson(responseBody["data"]);
    //     if (temp.newNotifications > 0 &&
    //         (_currentUserAccount.newNotifications != temp.newNotifications ||
    //             _currentUserAccount.newSubscriptions !=
    //                 temp.newSubscriptions)) {
    //       _showNewNotificationPanel = true;
    //     }
    //     _currentUserAccount.name = temp.name;
    //     _currentUserAccount.email = temp.email;
    //     _currentUserAccount.coins = temp.coins;
    //     _currentUserAccount.photo = temp.photo;
    //     _currentUserAccount.newNotifications = temp.newNotifications;
    //     _currentUserAccount.newSubscriptions = temp.newSubscriptions;
    //     notifyListeners();
    //     updateCurrentUserDetailsInPrefs(_currentUserAccount);
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }

  setCurrentUserTabs(TabModel tab) async {
    _currentUserAccount.tab = tab;
    notifyListeners();
    updateCurrentUserDetailsInPrefs(_currentUserAccount);
  }

  closeCurrentUserTabs(BuildContext context) async {
    synchronizeCurrentUser(context);
    _currentUserAccount.tab = null;
    notifyListeners();
    // updateCurrentUserDetailsInPrefs(_currentUserAccount);
  }

  updateCurrentUserDetailsInPrefs(UserAccount account) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          Strings.currentUserSPKey, jsonEncode(account.toJson()));
    } catch (e) {
      print("SHARE PRE $e");
    }
  }

  Future<ApiRequestModel> checkIfUserExists(UserAccount account) async {
    ApiRequestModel apiRequestModel = ApiRequestModel();
    try {
      var responseBody =
          await ApiRequest.get("users/check?email=" + account.attributes.email);
      if (responseBody["success"]) {
        UserAccount userAccount =
            UserAccount.fromJson(jsonDecode(responseBody["data"]));
        apiRequestModel.isSuccessful = true;
        apiRequestModel.result = userAccount;
        notifyListeners();
      } else {
        apiRequestModel = Validations()
            .getErrorMessage(responseBody['message'], responseBody['data']);
      }
    } catch (e) {
      print("dd $e");
      apiRequestModel.isSuccessful = false;
      apiRequestModel.errorMessage = "Internal error, please try again";
    }
    return apiRequestModel;
  }

  Future<ApiRequestModel> registerAccount(UserAccount account) async {
    ApiRequestModel apiRequestModel = ApiRequestModel();
    Map<String, dynamic> body = {
      "email": account.attributes.email,
      "password": account.attributes.password,
      "firstname": account.attributes.firstname,
      "lastname": account.attributes.lastname,
      "birth_date": account.attributes.birthDate.toString(),
    };
    try {
      var responseBody = await ApiRequest.post(body, "users");
      if (responseBody["success"]) {
        UserAccount userAccount = UserAccount.fromJson(responseBody["data"]);
        apiRequestModel.isSuccessful = true;
        apiRequestModel.result = userAccount;
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

  Future<ApiRequestModel> loginAccount(UserAccount account) async {
    ApiRequestModel apiRequestModel = ApiRequestModel();
    Map<String, dynamic> body = {
      "email": account.attributes.email,
      "password": account.attributes.password,
    };
    try {
      var responseBody = await ApiRequest.post(body, "users/login");
      if (responseBody["success"]) {
        _currentUserAccount = UserAccount.fromJson(responseBody["data"]);
        updateCurrentUserDetailsInPrefs(_currentUserAccount);
        apiRequestModel.isSuccessful = true;
        apiRequestModel.result = _currentUserAccount;
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
