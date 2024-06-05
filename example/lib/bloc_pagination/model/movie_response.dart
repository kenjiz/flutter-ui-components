import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:example/bloc_pagination/model/movie.dart';
import 'package:flutter/foundation.dart';

class MoviePageResponse extends Equatable {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  const MoviePageResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'results': results.map((x) => x.toMap()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  factory MoviePageResponse.fromMap(Map<String, dynamic> map) {
    return MoviePageResponse(
      page: map['page']?.toInt() ?? 0,
      results: List<Movie>.from(map['results']?.map((x) => Movie.fromMap(x))),
      totalPages: map['total_pages']?.toInt() ?? 0,
      totalResults: map['total_results']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MoviePageResponse.fromJson(String source) => MoviePageResponse.fromMap(json.decode(source));

  @override
  List<Object> get props => [page, results, totalPages, totalResults];

  @override
  bool? get stringify => kDebugMode;
}
