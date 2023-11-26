import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:ticket_toy/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ticket_toy/config.dart';
import 'package:ticket_toy/s.dart';
import 'package:palette_generator/palette_generator.dart';

class MoviesController extends GetxController {
  final movieList = Rxn<Movies>();
  final posterList = Rxn<Posters>();
  final selectedMovie = Rxn<MovieResults>();
  final selectedPoster = Rxn<ImageProvider>();
  final selectedColor = Rxn<PaletteGenerator>();
  final keyword = ''.obs;
  final capturedImage = Rxn<Uint8List>();
  final credits = Rxn<CastResult>();

  final isCollectionUploaded = false.obs;

  // my collection 저장 데이터
  final rating = Rxn<double>();
  final watchedAt = Rxn<DateTime>();
  final content = ''.obs;
  final isPost = false.obs;

  final ScreenshotController screenshotController = ScreenshotController();

  final S s = Get.find();

  final frame = const Image(
    image: AssetImage('assets/frame.png'),
  ).obs;

  Future fetchMovies() async {
    final response =
        await http.get(Uri.parse('$apiUrl/movie/list?search=${keyword.value}'));

    if (response.statusCode == 200) {
      movieList.value =
          Movies.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      update();
    } else {
      throw Exception('Failed to load movie list');
    }
  }

  Future fetchPosters() async {
    final response = await http.get(
        Uri.parse('$apiUrl/movie/posters?movie_id=${selectedMovie.value!.id}'));

    if (response.statusCode == 200) {
      posterList.value =
          Posters.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      update();
    } else {
      throw Exception('Failed to load poster list');
    }
  }

  Future fetchCasts() async {
    final response = await http
        .get(Uri.parse('$apiUrl/movie/credits/${selectedMovie.value!.id}'));

    if (response.statusCode == 200) {
      credits.value =
          CastResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      update();
    } else {
      throw Exception('Failed to load casts');
    }
  }

  Future postMyCollection() async {
    final url = Uri.parse('$apiUrl/user/collection');
    var request = http.MultipartRequest('POST', url);
    final httpImage = http.MultipartFile.fromBytes(
        'image', capturedImage.value!,
        contentType: MediaType('image', 'jpg'),
        filename: '${DateTime.now()}.jpg');
    request.headers.addAll({
      'Authorization': 'Bearer ${s.token.value}',
      'Content-type': 'multipart/form-data',
    });
    request.files.add(httpImage);
    request.fields.addAll({
      "rating": rating.value.toString(),
      "content": content.value,
      "movie_title": selectedMovie.value!.title,
      "movie_id": selectedMovie.value!.id.toString(),
      "watched_at": watchedAt.value.toString(),
    });

    final response = await request.send();

    if (response.statusCode == 200) {
      isCollectionUploaded.value = true;
      update();
    } else if (response.statusCode == 401) {
      await s.getToken();
      await postMyCollection();
    }
  }

  Future pickColor(ImageProvider image) async {
    selectedColor.value = await PaletteGenerator.fromImageProvider(image,
        size: const Size(200, 400));
  }
}
