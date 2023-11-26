import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Post extends GetView {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        'COMMING SOON',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
