import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_toy/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ticket_toy/config.dart';

class MoviesController extends GetxController {
  final movieList = Rxn<Movies>();
  final posterList = Rxn<Posters>();
  final selectedMovie = Rxn<MovieResults>();
  final selectedPoster = Rxn<Image>();
  final keyword = ''.obs;

  final frame = const Image(
    image: AssetImage('assets/frame.png'),
  ).obs;

  Future fetchMovies() async {
    final response = await http
        .get(Uri.parse('${Config.API_URL}/movies?search=${keyword.value}'));

    if (response.statusCode == 200) {
      movieList.value = Movies.fromJson(jsonDecode(response.body));
      update();
    } else {
      throw Exception('Failed to load movie list');
    }
  }

  Future fetchPosters() async {
    final response = await http.get(Uri.parse(
        '${Config.API_URL}/posters?movie_id=${selectedMovie.value!.id}'));

    if (response.statusCode == 200) {
      posterList.value = Posters.fromJson(jsonDecode(response.body));
      update();
    } else {
      throw Exception('Failed to load movie list');
    }
  }
}
