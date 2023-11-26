import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_toy/my_collection.dart';
import 'package:ticket_toy/my_collection_cotroller.dart';
import 'package:ticket_toy/s.dart';

class My extends GetView {
  My({super.key});

  final MyCollectionController myCon = Get.find();
  final S s = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (s.token.isEmpty) {
        return Align(
          alignment: Alignment.center,
          child: IconButton(
            icon: Image.asset('assets/kakao_login.png'),
            onPressed: () async {
              await s.getToken();
              await myCon.fetchMyCollections();
            },
          ),
        );
      }

      if (s.token.isNotEmpty && myCon.list.value == null) {
        myCon.fetchMyCollections();
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            children:
                List.generate(myCon.list.value!.myCollections.length, (index) {
              final myCollection = myCon.list.value!.myCollections[index];
              final image = Image.network(
                'https://totd.xyz/images/${myCollection.imageUrl}',
                scale: 5,
                fit: BoxFit.cover,
              );
              return InkWell(
                  child: image,
                  onTap: () async {
                    Get.to(MyCollectionPage(), arguments: {
                      'image': image,
                      'id': myCollection.id,
                    });
                  });
            }),
          )
        ],
      ));
    });
  }
}
