import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:Nuvle/misc/strings.dart';

class ApiRequest {
  static Future<Map<String, dynamic>> get(String pointer,
      [String token]) async {
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    };
    if (token != null) {
      headers.addAll({HttpHeaders.authorizationHeader: "Bearer " + token});
    }
    String url = Strings.baseUrl + '/$pointer';
    try {
      print(url);
      final res = await http.get(url, headers: headers);
      Map<String, dynamic> response = jsonDecode(res.body);
      return {
        "success": !response.containsKey('errors'),
        "data": response.containsKey('errors')
            ? response['errors']
            : response.containsKey('data') ? response['data'] : res.body
      };
    } catch (e) {
      return {"success": false, "message": e.message};
    }
  }

  static Future<Map<String, dynamic>> getWithBody(
      Map<String, dynamic> body, String pointer,
      [String token]) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    };
    if (token != null) {
      headers.addAll({HttpHeaders.authorizationHeader: "Bearer " + token});
    }
    Uri uri = Uri.parse(Strings.baseUrl + '/$pointer');
    final url = uri.replace(queryParameters: body);
    try {
      print(url);
      final res = await http.get(url, headers: headers);
      Map<String, dynamic> response = jsonDecode(res.body);
      return {
        "success": !response.containsKey('errors'),
        "data": response.containsKey('errors')
            ? response['errors']
            : response.containsKey('data') ? response['data'] : res.body
      };
    } catch (e) {
      return {"success": false, "message": e.message};
    }
  }

  static Future<Map<String, dynamic>> post(dynamic body, String pointer,
      [String token]) async {
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    };
    String url = Strings.baseUrl + '/$pointer';
    if (token != null) {
      headers.addAll({HttpHeaders.authorizationHeader: "Bearer " + token});
    }
    try {
      print(url);
      http.Response res = await http.post(url, headers: headers, body: body);
      Map<String, dynamic> response = jsonDecode(res.body);
      return {
        "success": !response.containsKey('errors'),
        "data": response.containsKey('errors')
            ? response['errors']
            : response.containsKey('data') ? response['data'] : res.body
      };
    } catch (e) {
      return {"success": false, "message": e.message};
    }
  }

  static Future<Map<String, dynamic>> postJSON(dynamic body, String pointer,
      [String token]) async {
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    String url = Strings.baseUrl + '/$pointer';
    if (token != null) {
      headers.addAll({HttpHeaders.authorizationHeader: "Bearer " + token});
    }
    try {
      print(url);
      http.Response res =
          await http.post(url, headers: headers, body: jsonEncode(body));
      Map<String, dynamic> response = jsonDecode(res.body);
      return {
        "success": !response.containsKey('errors'),
        "data": response.containsKey('errors')
            ? response['errors']
            : response.containsKey('data') ? response['data'] : res.body
      };
    } catch (e) {
      return {"success": false, "message": e.message};
    }
  }

  static Future<Map<String, dynamic>> delete(String pointer,
      [String token]) async {
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    };
    String url = Strings.baseUrl + '/$pointer';
    if (token != null) {
      headers.addAll({HttpHeaders.authorizationHeader: "Bearer " + token});
    }
    try {
      print(url);
      http.Response res = await http.delete(url, headers: headers);
      Map<String, dynamic> response = jsonDecode(res.body);
      return {
        "success": !response.containsKey('errors'),
        "data": response.containsKey('errors')
            ? response['errors']
            : response.containsKey('data') ? response['data'] : res.body
      };
    } catch (e) {
      return {"success": false, "message": e.message};
    }
  }
}
