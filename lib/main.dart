import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:screenshot/screenshot.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:ticket_toy/movie_controller.dart';
import 'package:ticket_toy/config.dart';
import 'package:ticket_toy/poster.dart';
import 'package:ticket_toy/s.dart';

void main() {
  KakaoSdk.init(javaScriptAppKey: '726e36b555c5df1c9ba09dbbb8340132');
  runApp(const TOTDApp());
}

class TOTDApp extends StatelessWidget {
  const TOTDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TOTD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TOTDHomePage(),
    );
  }
}

class TOTDHomePage extends StatelessWidget {
  final TextEditingController movieTitleController = TextEditingController();
  final MoviesController moviesController = Get.put(MoviesController());
  final MoviesController c = Get.find();
  final Step step = Get.put(Step());
  final Step sc = Get.find();
  final PosterController posterController = Get.put(PosterController());
  final PosterController p = Get.find();
  final S se = Get.put(S());
  final S sse = Get.find();

  ScreenshotController screenshotController = ScreenshotController();

  TOTDHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Center(child: Text("#TOTD | TICKET OF TODAY")),
        ),
        body: SingleChildScrollView(
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
                  () => sc.stepOne.value
                      ? SizedBox(
                          width: 500,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'STEP 1 | 영화',
                                  style: TextStyle(
                                      color: Colors.lightBlue[800],
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: EdgeInsets.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap),
                                      onPressed: () => _searchMovies(context),
                                      child: const Text(
                                        '영화 검색하기',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      )),
                                  Obx(() => c.selectedMovie.value != null
                                      ? Text(c.selectedMovie.value!.title)
                                      : const Text('영화를 선택해주세요')),
                                ],
                              )
                            ],
                          ))
                      : Container(),
                ),
                Obx(
                  () => c.selectedMovie.value != null
                      ? SizedBox(
                          width: 500,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'STEP 2 | 포스터',
                                  style: TextStyle(
                                      color: Colors.lightBlue[800],
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: EdgeInsets.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap),
                                      onPressed: () => {
                                            moviesController.fetchPosters(),
                                            _getPosters(context)
                                          },
                                      child: const Text(
                                        '포스터 선택하기',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      )),
                                  Obx(
                                    () => c.selectedPoster.value != null
                                        ? const Text("포스터 선택 완료!")
                                        : const Text('포스터를 선택해주세요'),
                                  )
                                ],
                              )
                            ],
                          ))
                      : Container(),
                ),
                Obx(() => c.selectedPoster.value != null
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
                                  controller: screenshotController,
                                  child: SizedBox(
                                    width: 500,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SizedBox(
                                                width: 250,
                                                height: 500,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: c
                                                              .selectedPoster
                                                              .value!
                                                              .image,
                                                          fit: BoxFit
                                                              .fitHeight)),
                                                )),
                                            IgnorePointer(
                                                child: SizedBox(
                                              width: 250,
                                              child: c.frame.value,
                                            )),
                                          ],
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SizedBox(
                                                width: 250,
                                                height: 500,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: c
                                                              .selectedPoster
                                                              .value!
                                                              .image,
                                                          fit: BoxFit.fitHeight,
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                            Colors.white
                                                                .withOpacity(
                                                                    0.5),
                                                            BlendMode.modulate,
                                                          ))),
                                                )),
                                            IgnorePointer(
                                                child: SizedBox(
                                              width: 250,
                                              child: c.frame.value,
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))),
                          ElevatedButton(
                            onPressed: () async {
                              var s = await screenshotController
                                  .capture()
                                  .catchError((e) {
                                return null;
                              });
                              moviesController.capturedImage.value = s;
                              await se.get();
                            },
                            child: const Text('이미지 캡처'),
                          ),
                        ],
                      )
                    : Container()),
              ],
            ),
          ),
        ));
  }

  Future<void> _searchMovies(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text('영화 검색'),
          ),
          shadowColor: ColorEffect.neutralValue,
          content: SizedBox(
              width: 500,
              height: 600,
              child: Column(children: [
                TextField(
                    controller: movieTitleController,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) async {
                      moviesController.keyword.value =
                          movieTitleController.text.toString();
                      moviesController.fetchMovies();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '제목을 입력하세요',
                    )),
                Obx(() => c.movieList.value != null
                    ? SizedBox(
                        width: 500,
                        height: 500,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: c.movieList.value!.results.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  child: SizedBox(
                                    child: Row(children: [
                                      Image.network(
                                        '${Config.IMAGE_URL}/${c.movieList.value!.results[index].posterPath}',
                                        scale: 5,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(c.movieList.value!.results[index]
                                              .title),
                                          Text(
                                              '개봉일 | ${c.movieList.value!.results[index].releaseDate}'),
                                        ],
                                      )
                                    ]),
                                  ),
                                  onTap: () {
                                    moviesController.selectedMovie.value =
                                        c.movieList.value!.results[index];
                                    Navigator.pop(context);
                                  });
                            }))
                    : Container())
              ])),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('검색'),
              onPressed: () {
                moviesController.keyword.value =
                    movieTitleController.text.toString();
                moviesController.fetchMovies();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getPosters(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text('포스터 선택'),
          ),
          shadowColor: ColorEffect.neutralValue,
          content: SizedBox(
              width: 500,
              height: 600,
              child: Column(children: [
                Obx(() => c.posterList.value != null
                    ? SizedBox(
                        width: 500,
                        height: 500,
                        child: GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          children: List.generate(
                              c.movieList.value!.results.length, (index) {
                            return InkWell(
                                child: Image.network(
                                  '${Config.IMAGE_URL}/${c.posterList.value!.posters[index].filePath}',
                                  scale: 5,
                                ),
                                onTap: () {
                                  moviesController.selectedPoster.value =
                                      Image.network(
                                    '${Config.IMAGE_URL}/${c.posterList.value!.posters[index].filePath}',
                                    scale: 4,
                                  );
                                  Navigator.pop(context);
                                });
                          }),
                        ))
                    : Container())
              ])),
        );
      },
    );
  }
}

class Step extends GetxController {
  final stepOne = false.obs;
}


// class SearchMovieRouter extends StatelessWidget {
//   const SearchMovieRouter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Center(
//           child: SearchAnchor(
//               builder: (BuildContext context, SearchController controller) {
//             return SearchBar(
//               shadowColor:
//                   MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
//               controller: controller,
//               padding: const MaterialStatePropertyAll<EdgeInsets>(
//                   EdgeInsets.symmetric(horizontal: 16.0)),
//               onTap: () {
//                 controller.openView();
//               },
//               onChanged: (_) {
//                 controller.openView();
//               },
//               leading: const Icon(Icons.search),
//               trailing: <Widget>[
//                 Tooltip(
//                   message: 'Change brightness mode',
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.wb_sunny_outlined),
//                     selectedIcon: const Icon(Icons.brightness_2_outlined),
//                   ),
//                 )
//               ],
//             );
//           }, suggestionsBuilder:
//                   (BuildContext context, SearchController controller) {
//             return [const Text("")];
//           }),
//         )
//       ],
//     );
//   }
// }

// InteractiveViewer(
//   boundaryMargin:
//       const EdgeInsets.all(500.0),
//   minScale: 1,
//   maxScale: 5,
//   child: c.selectedPoster.value!,
// ),

