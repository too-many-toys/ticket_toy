import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:get/get.dart';
import 'package:ticket_toy/home.dart';
import 'package:ticket_toy/my.dart';
import 'package:ticket_toy/post.dart';

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

class TOTDHomePage extends GetView<LandingPageController> {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);
  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);
  TOTDHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);

    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              const Post(),
              HomePage(),
              const My(),
              // ExplorePage(),
              // PlacesPage(),
              // SettingsPage(),
            ],
          )),
    ));
  }

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: Colors.white,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.explore,
                    size: 20.0,
                  ),
                ),
                label: 'Posts',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.home,
                    size: 20.0,
                  ),
                ),
                label: 'Home',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.account_box,
                    size: 20.0,
                  ),
                ),
                label: 'My',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
            ],
          ),
        )));
  }
}

class LandingPageController extends GetxController {
  var tabIndex = 1.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
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

