import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_toy/movie_controller.dart';
import 'package:ticket_toy/config.dart';

class SearchMovie extends GetView<MoviesController> {
  final TextEditingController movieTitleController = TextEditingController();

  SearchMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            width: 500,
            height: Get.height,
            child: Material(
                child: Column(children: [
              Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: TextField(
                      controller: movieTitleController,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) async {
                        controller.keyword.value =
                            movieTitleController.text.toString();
                        controller.fetchMovies();
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '제목을 입력하세요',
                      ))),
              Obx(() => controller.movieList.value != null
                  ? SizedBox(
                      width: 500,
                      height: Get.height - 80,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.movieList.value!.results.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                child: SizedBox(
                                  child: Row(children: [
                                    Image.network(
                                      '${Config.imageUrl}/${controller.movieList.value!.results[index].posterPath}',
                                      scale: 5,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(controller.movieList.value!
                                            .results[index].title),
                                        Text(
                                            '개봉일 | ${controller.movieList.value!.results[index].releaseDate}'),
                                      ],
                                    )
                                  ]),
                                ),
                                onTap: () {
                                  controller.selectedMovie.value = controller
                                      .movieList.value!.results[index];
                                  Get.back();
                                });
                          }))
                  : Container())
            ]))));
  }
}
