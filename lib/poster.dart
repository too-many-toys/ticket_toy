import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosterController extends GetxController {
  final image = Rxn<Image>();
  final x = 0.0.obs;
  final y = 0.0.obs;
  final scale = 1.0.obs;

  void setImage(Image image) {
    this.image.value = image;
    update();
  }
}
