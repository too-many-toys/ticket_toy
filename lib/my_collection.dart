import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ticket_toy/model.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_toy/config.dart';
import 'package:ticket_toy/s.dart';

class MyCollectionPage extends GetView {
  MyCollectionPage({super.key});

  final detail = Rxn<CollectionDetail>();
  final S s = Get.find();

  @override
  Widget build(BuildContext context) {
    final image = Get.arguments['image'];
    fetchDetail(Get.arguments['id']);
    final textCon = TextEditingController();

    return SafeArea(
        child: Material(
            child: SingleChildScrollView(
      child: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: Get.width,
              child: image,
            ),
            Obx(() {
              if (detail.value != null) {
                textCon.text = detail.value!.content;
                return Column(children: [
                  RatingBar.builder(
                    initialRating: detail.value!.rating,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return const Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return const Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.redAccent,
                          );
                        case 2:
                          return const Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          );
                        case 3:
                          return const Icon(
                            Icons.sentiment_satisfied,
                            color: Colors.lightGreen,
                          );
                        case 4:
                          return const Icon(
                            Icons.sentiment_very_satisfied,
                            color: Colors.green,
                          );
                      }
                      return Container();
                    },
                    onRatingUpdate: (rating) {
                      controller.rating.value = rating;
                    },
                  ),
                  Text(
                    detail.value!.movieTitle,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      controller: textCon,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        controller.content.value = textCon.text;
                      },
                      child: const Text('수정')),
                  const SizedBox(
                    height: 80,
                  )
                ]);
              }
              return const Center(child: CircularProgressIndicator());
            })
          ],
        ),
      ),
    )));
  }

  Future fetchDetail(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/user/collection/$id'),
        headers: {
          'Authorization': 'Bearer ${s.token.value}',
          'Content-type': 'application/json'
        });

    if (response.statusCode == 200) {
      detail.value = CollectionDetail.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load movie detail');
    }
  }
}
