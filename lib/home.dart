import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:ticket_toy/movie_controller.dart';
import 'package:ticket_toy/s.dart';
import 'package:ticket_toy/search_movie.dart';
import 'package:ticket_toy/search_poster.dart';
import 'package:ticket_toy/send_collection.dart';
import 'package:ticket_toy/ticket_painter.dart';

class HomePage extends GetView {
  HomePage({super.key});

  final isWebMobile = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  final TextEditingController movieTitleController = TextEditingController();
  final MoviesController movieController = Get.find();

  final S sController = Get.find();
  final Step step = Get.put(Step());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(20)),
            const SizedBox(
              width: 500,
              child: ScrollLoopAutoScroll(
                duration: Duration(seconds: 100),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/1.jpg'),
                      width: 200,
                      height: 200,
                    ),
                    Image(
                      image: AssetImage('assets/2.jpg'),
                      width: 200,
                      height: 200,
                    ),
                    Image(
                      image: AssetImage('assets/3.jpg'),
                      width: 200,
                      height: 200,
                    ),
                    Image(
                      image: AssetImage('assets/4.jpg'),
                      width: 200,
                      height: 200,
                    ),
                    Image(
                      image: AssetImage('assets/5.jpg'),
                      width: 200,
                      height: 200,
                    ),
                    Image(
                      image: AssetImage('assets/6.jpg'),
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(20)),
            const Text(
              '어떤 영화든 OK!',
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              '단 !2-STEP! 으로 뚝딱 만드는',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              '디지털 오리지널 티켓',
              style: TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.all(20)),
            const Text('🎬 내가 본 영화는 오리지널 티켓이 안 나왔어요'),
            const Padding(padding: EdgeInsets.all(5)),
            const Text('🎟️ 갖고는 싶은데 수량이 적어서 너무 빨리 동나요'),
            const Padding(padding: EdgeInsets.all(5)),
            const Text(
                '✍🏻 노션, 인스타, 블로그에 영화 리뷰를 작성할 때\n      오리지널 티켓 이미지를 첨부하고 싶어요'),
            const Padding(padding: EdgeInsets.all(20)),
            const Text('이 중 하나라도 해당된다면,'),
            ElevatedButton(
                onPressed: () {
                  step.stepOne.value = true;
                },
                child: const Text('디지털 오리지널 티켓 만들기 👇🏻')),
            const SizedBox(height: 30),
            Obx(
              () => step.stepOne.value
                  ? SizedBox(
                      width: 300,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'STEP 1 | 영화',
                              style: TextStyle(
                                  color: Colors.lightBlue[800], fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextButton(
                                  style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap),
                                  onPressed: () => Get.to(SearchMovie()),
                                  child: const Text(
                                    '영화 검색하기',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                              Obx(() =>
                                  movieController.selectedMovie.value != null
                                      ? Text(movieController
                                          .selectedMovie.value!.title)
                                      : const Text('영화를 선택해주세요')),
                            ],
                          )
                        ],
                      ))
                  : Container(),
            ),
            Obx(
              () => movieController.selectedMovie.value != null
                  ? SizedBox(
                      width: 300,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'STEP 2 | 포스터',
                              style: TextStyle(
                                  color: Colors.lightBlue[800], fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextButton(
                                  style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap),
                                  onPressed: () => {
                                        movieController.fetchPosters(),
                                        Get.to(SearchPoster())
                                      },
                                  child: const Text(
                                    '포스터 선택하기',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                              Obx(
                                () =>
                                    movieController.selectedPoster.value != null
                                        ? const Text("포스터 선택 완료!")
                                        : const Text('포스터를 선택해주세요'),
                              )
                            ],
                          )
                        ],
                      ))
                  : Container(),
            ),
            Obx(() => movieController.selectedPoster.value != null
                ? Column(
                    children: [
                      const Text("완성 | 아래로 스크롤해 결과물을 확인하세요!"),
                      const Text("TIP! PC보다 모바일에서 더 선명하게 나와요"),
                      const Text("완성된 디지털 오리지널 티켓은 캡처하셔서"),
                      const Text("인스타그램, 블로그, 노션 등 원하는 곳에 사용하시면 됩니다."),
                      const Text(""),
                      const Text(
                        "#TOTD도 함께 소개해주세요👏🏻",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      const Text(""),
                      const Text(
                        "**오리지널 티켓의 디자인 저작권은 메가박스에 있습니다.",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: Screenshot(
                              controller: movieController.screenshotController,
                              child: SizedBox(
                                width: 400,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                            width: 200,
                                            height: 400,
                                            child: Container(
                                              height: 400,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      image: movieController
                                                          .selectedPoster
                                                          .value!,
                                                      fit: BoxFit.fitHeight)),
                                            )),
                                        SizedBox(
                                          width: 200,
                                          height: 400,
                                          child: movieController.frame.value,
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                            width: 200,
                                            height: 400,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      image: movieController
                                                          .selectedPoster
                                                          .value!,
                                                      fit: BoxFit.fitHeight,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        movieController
                                                            .selectedColor
                                                            .value!
                                                            .darkVibrantColor!
                                                            .color
                                                            .withOpacity(0.8),
                                                        BlendMode.darken,
                                                      ))),
                                            )),
                                        SizedBox(
                                          width: 200,
                                          height: 400,
                                          child: movieController.frame.value,
                                        ),
                                        SizedBox(
                                            width: 200,
                                            height: 400,
                                            child: Align(
                                              alignment:
                                                  const Alignment(-1.0, -1.0),
                                              child: Obx(
                                                () => movieController
                                                            .credits.value !=
                                                        null
                                                    ? CustomPaint(
                                                        painter:
                                                            TicketPainter(),
                                                      )
                                                    : Container(),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ))),
                      ElevatedButton(
                        onPressed: () async {
                          var s = await movieController.screenshotController
                              .capture()
                              .catchError((e) {
                            return null;
                          });
                          movieController.capturedImage.value = s;

                          Get.dialog(SendCollection()).then((value) =>
                              movieController.isCollectionUploaded.value =
                                  false);
                        },
                        child: const Text('감상 저장하기'),
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  )
                : Container()),
          ],
        ),
      ),
    );
  }
}

class Step extends GetxController {
  final stepOne = false.obs;
}
