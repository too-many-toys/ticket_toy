import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:ticket_toy/config.dart';

class S extends GetxController {
  late final SharedPreferences storage;
  final token = ''.obs;

  Future init() async {
    storage = await SharedPreferences.getInstance();
    if (storage.getString("token") != null) {
      token.value = storage.getString("token") as String;
    }
  }

  Future getToken() async {
    final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
      'client_id': '726e36b555c5df1c9ba09dbbb8340132',
      'redirect_uri': redirectUrl,
      'response_type': 'code',
    });
    final result = await FlutterWebAuth2.authenticate(
        url: url.toString(), callbackUrlScheme: "webauthcallback");

    final code = Uri.parse(result).queryParameters['code'] as String;
    final accessTokenUri = Uri.https('kauth.kakao.com', '/oauth/token', {
      'grant_type': 'authorization_code',
      'client_id': '726e36b555c5df1c9ba09dbbb8340132',
      'redirect_uri': redirectUrl,
      'code': code,
    });
    final accessTokenResult = await http.post(accessTokenUri);
    final accessToken = json.decode(accessTokenResult.body)['access_token'];

    final tokenUrl = Uri.https('kapi.kakao.com', '/v2/user/me');
    final tokenResponse = await http.post(tokenUrl, headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-type': 'application/x-www-form-urlencoded;charset=utf-8',
    });

    Uri? signinUrl;
    if (kDebugMode) {
      signinUrl = Uri.http('localhost:3000', 'user/signin');
    } else {
      signinUrl = Uri.https('totd.xyz', 'api/user/signin');
    }
    final userInfo = json.decode(tokenResponse.body);
    final tokenResult = await http.post(signinUrl,
        body: json.encode({
          "uid": userInfo['id'].toString(),
          "account_type": "Kakao",
        }),
        headers: {'Content-type': 'application/json'});

    token.value = json.decode(tokenResult.body)['token'];
    await storage.setString("token", token.value);
  }
}

class SS {
  final String s;

  SS({required this.s});

  factory SS.fromJson(Map<String, dynamic> json) {
    return SS(
      s: json['token'] as String,
    );
  }
}
