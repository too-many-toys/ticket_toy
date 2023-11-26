import 'dart:convert';

import 'package:get/get.dart';
import 'package:ticket_toy/model.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_toy/config.dart';
import 'package:ticket_toy/s.dart';

class MyCollectionController extends GetxController {
  final list = Rxn<MyCollectionResult>();

  final S s = Get.find();

  Future fetchMyCollections() async {
    final response = await http.get(Uri.parse('$apiUrl/user/collections'),
        headers: {
          'Authorization': 'Bearer ${s.token.value}',
          'Content-type': 'application/json'
        });

    if (response.statusCode == 200) {
      list.value = MyCollectionResult.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      update();
    } else if (response.statusCode == 401) {
      await s.getToken();
      await fetchMyCollections();
    }
  }

  Future modifyMyCollection() async {
    final response = await http.post(Uri.parse('$apiUrl/user/collections'),
        headers: {
          'Authorization': 'Bearer ${s.token.value}',
          'Content-type': 'application/json'
        },
        body: json.encode({}));

    if (response.statusCode == 200) {
      update();
    } else if (response.statusCode == 401) {
      await s.getToken();
      await modifyMyCollection();
    }
  }
}
