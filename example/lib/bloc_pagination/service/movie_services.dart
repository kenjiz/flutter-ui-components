import 'dart:convert';
import 'package:example/bloc_pagination/model/movie_filter.dart';
import 'package:example/bloc_pagination/model/movie_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';
import 'package:http/http.dart' as http;

class MovieService {
  String apiKey = '';

  MovieService() {
    if (dotenv.isInitialized) {
      apiKey = dotenv.env['API_ACCESS_TOKEN']!;
    }
  }

  Future<MoviePageResponse> fetchPopularMovies({required int page, Filter? filter}) async {
    final movieFilter = (filter ?? const MovieFilter(type: MovieType.popular)) as MovieFilter;

    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/${movieFilter.type.name}?page=$page'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'accept': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final results = json.decode(response.body);
      return MoviePageResponse.fromMap(results);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
