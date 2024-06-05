import 'package:example/bloc_pagination/model/movie.dart';
import 'package:example/bloc_pagination/service/movie_services.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

class MovieRepository {
  MovieRepository({
    required this.service,
  });

  final MovieService service;

  Future<FetchedList<Movie>> fetchPopularMovies(int page, Filter? filter) async {
    try {
      final response = await service.fetchPopularMovies(page: page);
      return FetchedList<Movie>(
        hasNext: response.totalPages >= page,
        items: response.results,
        nextPage: response.page + 1,
      );
    } catch (e) {
      rethrow;
    }
  }
}
