import 'package:nuvlemobile/misc/enum.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';

class Validations {
  String validateName(String value) {
    if (value.isEmpty) return 'Name is Required.';
    final RegExp nameExp = new RegExp(r'^[A-za-z\- ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  String validateEmail(String value, [bool isRequried = true]) {
    if (value.isEmpty && isRequried) return 'Email is required.';
    final RegExp nameExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value) && isRequried) return 'Invalid email address';
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'Please enter a password.';
    if (value.length < 8) return 'Minimum of 8-characters for password.';
    return null;
  }

  String validateRePassword(String value, String prevPass) {
    if (value.isEmpty) return 'Please re-enter your password.';
    if (prevPass != value) return 'Password does not match';
    return null;
  }

  APIRequestStatus getAPIErrorType(String message) {
    APIRequestStatus apiRequestStatus;
    if (message != null &&
        (message == "Connection failed" ||
            message.toString().contains("Failed host lookup"))) {
      apiRequestStatus = APIRequestStatus.connectionError;
    } else if (message.toString().contains("User not authorized") ||
        message.toString().contains("Invalid access token")) {
      apiRequestStatus = APIRequestStatus.unauthorized;
    } else if (message != null &&
        (message.toString().contains("Future not completed"))) {
      apiRequestStatus = APIRequestStatus.connectionError;
    } else {
      apiRequestStatus = APIRequestStatus.error;
    }
    return apiRequestStatus;
  }

  ApiRequestModel getErrorMessage(String message, var errors) {
    ApiRequestModel apiRequestModel = ApiRequestModel();
    if (message != null &&
        (message == "Connection failed" ||
            message.toString().contains("Failed host lookup"))) {
      apiRequestModel.isSuccessful = false;
      apiRequestModel.errorMessage = "Error establishing internet connection";
    } else if (message != null &&
        (message.toString().contains("Future not completed"))) {
      apiRequestModel.isSuccessful = false;
      apiRequestModel.errorMessage = "Slow internet connection";
    } else if (errors != null) {
      String errMessage = "";
      for (var error in errors) {
        errMessage += error["detail"] + "\n";
      }
      apiRequestModel.isSuccessful = false;
      apiRequestModel.errorMessage = errMessage;
    } else {
      apiRequestModel.isSuccessful = false;
      apiRequestModel.errorMessage = message;
    }
    return apiRequestModel;
  }
}
