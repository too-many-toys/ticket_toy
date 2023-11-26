import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ticket_toy/movie_controller.dart';
import 'package:ticket_toy/my_collection_cotroller.dart';

class SendCollection extends GetView<MoviesController> {
  SendCollection({super.key});

  final TextEditingController textCon = TextEditingController();
  final MyCollectionController myCon = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.rating.value = 3;
    return SafeArea(
        child: Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 10,
      backgroundColor: Colors.black,
      child: SizedBox(
          width: 400,
          height: 600,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
              ),
              Obx(() => !controller.isCollectionUploaded.value
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.memory(
                            controller.capturedImage.value!,
                            width: 200,
                          ),
                          RatingBar.builder(
                            initialRating: 3,
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: 400,
                            child: TextField(
                              controller: textCon,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                hintText: '감상을 적어주세요 ',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                );
                                controller.watchedAt.value = selectedDate;
                              },
                              child: Obx(() => controller.watchedAt.value !=
                                      null
                                  ? Text(
                                      '${controller.watchedAt.value!.year}년 ${controller.watchedAt.value!.month}월 ${controller.watchedAt.value!.day}일')
                                  : const Text('관람 날짜 (선택)'))),
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("감상평을 포스트에 올리시렵니까?"),
                                  Checkbox(
                                    value: controller.isPost.value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        controller.isPost.value = value;
                                      }
                                    },
                                  )
                                ],
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                controller.content.value = textCon.text;
                                await controller.postMyCollection();
                                myCon.fetchMyCollections();
                              },
                              child: const Text('저장!'))
                        ],
                      ))
                  : Stack(
                      children: [
                        const Align(
                            alignment: Alignment.center, child: Text('저장 완료!')),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('닫기')),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    )),
            ],
          )),
    ));
  }
}
