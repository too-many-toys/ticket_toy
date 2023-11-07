import 'package:get/get.dart';
import 'package:ticket_toy/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ticket_toy/config.dart';

class MoviesController extends GetxController {
  final movieList = Rxn<Movies>();
  final isDrawing = false.obs;
  final selectedMovie = Rxn<MovieResults>();
  final keyword = ''.obs;

  Future fetchMovieList() async {
    isDrawing.value = false;
    final response = await http
        .get(Uri.parse('${Config.API_URL}/movies?search=${keyword.value}'));

    if (response.statusCode == 200) {
      movieList.value = Movies.fromJson(jsonDecode(response.body));
      isDrawing.value = true;
      update();
    } else {
      throw Exception('Failed to load movie list');
    }
  }
}
