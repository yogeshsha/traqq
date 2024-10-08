import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode  ;
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

import '../widgets/simple_text.dart';


class AppHelper {



  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }




  static showSnakeBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SimpleText(
        text:text,
        style:
        TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 10,
    ));
  }


  static void myPrint(Object? value) {
    if (kDebugMode) {
      dev.log(value.toString());
    }
  }



  static Future<http.Response> callApi(
      {String apiType = "get",
        bool isJsonEncode = false,
        bool tokenRequired = false,
        required String url,
        Map? body}) async {
    try {

      http.Response? response;
      Map<String, String> headers = {};
      if (tokenRequired) {
        headers.addAll({
          'Authorization': 'Bearer #token'
        });
      }
      if (isJsonEncode) {
        headers.addAll({"content-type": "application/json"});
      }

      Object? sendBody;

      if (body != null) {
        sendBody = isJsonEncode ? json.encode(body) : body;
      }

      if (apiType == "post") {
        response =
        await http.post(Uri.parse(url), body: sendBody, headers: headers);
      } else if (apiType == "put") {
        response =
        await http.put(Uri.parse(url), body: sendBody, headers: headers);
      } else if (apiType == "delete") {
        response =
        await http.delete(Uri.parse(url), body: sendBody, headers: headers);
      } else {
        response = await http.get(Uri.parse(url), headers: headers);
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  static bool isValidUrl(String url) {
    Uri? uri = Uri.tryParse(url);
    return uri != null && uri.scheme.isNotEmpty && uri.hasAuthority;
  }

}