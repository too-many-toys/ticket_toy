import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_toy/movie_controller.dart';

class TicketPainter extends CustomPainter {
  final MoviesController movieController = Get.find();

  final ticketPainter = TextPainter()
    ..text = const TextSpan(
      text: 'ORIGINAL TICKET',
      style: TextStyle(
        fontSize: 9,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    )
    ..textAlign = TextAlign.left
    ..textDirection = TextDirection.ltr
    ..layout();
  final noPainter = TextPainter()
    ..text = const TextSpan(
      // TODO: count 센 번호 여기에 삽입
      // 숫자가 커질수록 왼쪽으로 밀리게
      text: 'No.000000001',
      style: TextStyle(
        fontSize: 9,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    )
    ..textAlign = TextAlign.right
    ..textDirection = TextDirection.ltr
    ..reactive
    ..layout();
  final titlePainter = TextPainter()
    ..text = const TextSpan(
      text: 'Title',
      style: TextStyle(
        fontSize: 8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    )
    ..textAlign = TextAlign.left
    ..textDirection = TextDirection.ltr
    ..layout();
  final directorPainter = TextPainter()
    ..text = const TextSpan(
      text: 'Director',
      style: TextStyle(
        fontSize: 8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    )
    ..textAlign = TextAlign.left
    ..textDirection = TextDirection.ltr
    ..layout();
  final cast = "Cast";
  final castPainter = TextPainter()
    ..text = const TextSpan(
      text: 'Cast',
      style: TextStyle(
        fontSize: 8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    )
    ..textAlign = TextAlign.left
    ..textDirection = TextDirection.ltr
    ..layout();
  final release = "Release";
  final releasePainter = TextPainter()
    ..text = const TextSpan(
      text: 'Release',
      style: TextStyle(
        fontSize: 8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    )
    ..textAlign = TextAlign.left
    ..textDirection = TextDirection.ltr
    ..layout();
  final date = "Date";
  final theater = "Theater";
  final seat = "Seat";
  final mark = "TICKET OF TODAY";
  final markPainter = TextPainter()
    ..text = const TextSpan(
      text: 'TICKET OF TODAY',
      style: TextStyle(
        fontSize: 9,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    )
    ..textAlign = TextAlign.left
    ..textDirection = TextDirection.ltr
    ..layout();

  final commingSoonPainter = TextPainter()
    ..text = const TextSpan(
      text: 'COMING SOON',
      style: TextStyle(
        fontSize: 8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    )
    ..textAlign = TextAlign.left
    ..textDirection = TextDirection.ltr
    ..layout();

  @override
  void paint(Canvas canvas, Size size) {
    final title = TextPainter()
      ..text = TextSpan(
        text: movieController.selectedMovie.value!.originalTitle,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      )
      ..textAlign = TextAlign.center
      ..textDirection = TextDirection.ltr
      ..layout();
    final director = TextPainter()
      ..text = TextSpan(
        text: movieController.credits.value!.crew
            .map((e) => e.originalName)
            .join("  "),
        style: const TextStyle(
          fontSize: 8,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      )
      ..textAlign = TextAlign.center
      ..textDirection = TextDirection.ltr
      ..layout();
    final cast = TextPainter()
      ..text = TextSpan(
        text: movieController.credits.value!.cast
            .map((e) => e.originalName)
            .join("  "),
        style: const TextStyle(
          fontSize: 8,
          color: Colors.white,
        ),
      )
      ..textAlign = TextAlign.center
      ..textDirection = TextDirection.ltr
      ..layout(maxWidth: 200 - 40);
    final release = TextPainter()
      ..text = TextSpan(
        text: movieController.selectedMovie.value!.releaseDate,
        style: const TextStyle(
          fontSize: 8,
          color: Colors.white,
        ),
      )
      ..textAlign = TextAlign.center
      ..textDirection = TextDirection.ltr
      ..layout();

    /// Start Painting
    final line = Paint()
      ..color = const Color.fromRGBO(255, 255, 255, 1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    ticketPainter.paint(canvas, const Offset(12, 30));
    noPainter.paint(canvas, const Offset(130, 30));
    canvas.drawRect(const Offset(12, 45) & const Size(176, 310), line);
    titlePainter.paint(canvas, const Offset(20, 50));
    title.paint(canvas, Offset(100 - (title.size.width / 2), 70));
    canvas.drawLine(const Offset(12, 120), const Offset(188, 120), line);
    directorPainter.paint(canvas, const Offset(20, 125));
    director.paint(canvas, Offset(100 - (director.size.width / 2), 140));
    canvas.drawLine(const Offset(12, 160), const Offset(188, 160), line);
    castPainter.paint(canvas, const Offset(20, 165));
    cast.paint(canvas, Offset(100 - (cast.size.width / 2), 180));
    canvas.drawLine(const Offset(12, 220), const Offset(188, 220), line);
    releasePainter.paint(canvas, const Offset(20, 225));
    release.paint(canvas, Offset(100 - (release.size.width / 2), 240));
    canvas.drawLine(const Offset(12, 260), const Offset(188, 260), line);
    commingSoonPainter.paint(canvas, const Offset(20, 265));

    markPainter.paint(canvas, const Offset(65, 365));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
