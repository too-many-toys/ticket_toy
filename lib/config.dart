import 'package:flutter/foundation.dart';

class Config {
  static const String apiUrl = 'https://totd.xyz/api';
  static const String imageUrl = 'https://image.tmdb.org/t/p/w500';
}

String? apiUrl;
String? imageUrl;
String? redirectUrl;

void variableInit() {
  if (kDebugMode) {
    apiUrl = 'http://localhost:3000';
    imageUrl = 'https://image.tmdb.org/t/p/w500';
    redirectUrl = 'http://localhost:7357/kakao.html';
  } else {
    apiUrl = 'https://totd.xyz/api';
    imageUrl = 'https://image.tmdb.org/t/p/w500';
    redirectUrl = 'https://totd.xyz/kakao.html';
  }
}
