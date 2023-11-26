import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_toy/movie_controller.dart';
import 'package:ticket_toy/config.dart';

class SearchPoster extends GetView<MoviesController> {
  final TextEditingController movieTitleController = TextEditingController();

  SearchPoster({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            width: 500,
            height: Get.height,
            child: Material(
                child: Column(children: [
              Obx(() => controller.posterList.value != null
                  ? SizedBox(
                      width: 500,
                      height: Get.height - 80,
                      child: GridView(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        children: List.generate(
                            controller.movieList.value!.results.length,
                            (index) {
                          final posterImage = Image.network(
                            '${Config.imageUrl}/${controller.posterList.value!.posters[index].filePath}',
                            scale: 5,
                          );
                          return InkWell(
                              child: posterImage,
                              onTap: () async {
                                controller.selectedPoster.value =
                                    posterImage.image;

                                await controller.pickColor(posterImage.image);
                                await controller.fetchCasts();
                                Get.back();
                              });
                        }),
                      ))
                  : Container())
            ]))));
  }
}
