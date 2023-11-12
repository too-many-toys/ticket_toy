import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ticket_toy/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class S extends GetxController {
  final storage = const FlutterSecureStorage();
  late String s;

  Future get() async {
    if (await storage.read(key: "token") == null) {
      if (await isKakaoTalkInstalled()) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
        } catch (error) {
          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (error is PlatformException && error.code == 'CANCELED') {
            return;
          }
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
          await UserApi.instance.loginWithKakaoAccount();
        }
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }
      User user = await UserApi.instance.me();
      final response = await http.post(
          Uri.parse('${Config.API_URL}/user/signin'),
          body: {"uid": user.id.toString(), "account_type": "Kakao"});
      if (response.statusCode == 200) {
        s = SS.fromJson(jsonDecode(utf8.decode(response.bodyBytes))).s;
        update();
      } else {
        throw Exception('Failed to load jwt');
      }
      await storage.write(key: "token", value: s);
    } else {
      s = await storage.read(key: "token") as String;
    }
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
