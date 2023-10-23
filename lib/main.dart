import 'package:flutter/material.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

void main() {
  runApp(const TOTDApp());
}

class TOTDApp extends StatelessWidget {
  const TOTDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TOTDHomePage(title: '#TOTD | TICKET OF TODAY'),
    );
  }
}

class TOTDHomePage extends StatefulWidget {
  const TOTDHomePage({super.key, required this.title});

  final String title;

  @override
  State<TOTDHomePage> createState() => _TOTDHomePageState();
}

class _TOTDHomePageState extends State<TOTDHomePage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
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
            const Text('어떤 영화든 OK!'),
            const Text('단 2-STEP 으로 뚝딱 만드는'),
            const Text('디지털 오리지널 티켓'),
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
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('You clicked ElevatedButton.')));
                },
                child: const Text('디지털 오리지널 티켓 만들기')),
          ],
        ),
      ),
    );
  }
}
