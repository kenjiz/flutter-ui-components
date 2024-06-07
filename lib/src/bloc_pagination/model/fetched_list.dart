// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_ui_components/flutter_ui_components.dart';

class FetchedList<T> extends Equatable {
  /// A generic class that represents a list of fetched items from an API.
  ///
  const FetchedList({
    required this.hasNext,
    required this.items,
    this.nextPage,
    this.filter,
  });

  FetchedList.empty()
      : hasNext = false,
        items = <T>[],
        nextPage = null,
        filter = null;

  /// {@macro hasNext}
  final bool hasNext;

  /// {@macro items}
  final List<T> items;

  /// {@macro nextPage}
  final int? nextPage;

  /// {@macro filter}
  final Filter? filter;

  FetchedList<T> operator +(covariant FetchedList<T> other) {
    return FetchedList<T>(
      hasNext: hasNext || other.hasNext,
      items: [...items, ...other.items],
      nextPage: other.nextPage,
      filter: filter,
    );
  }

  FetchedList<T> copyWith({
    bool? hasNext,
    List<T>? items,
    int? nextPage,
    Filter? filter,
  }) {
    return FetchedList<T>(
      hasNext: hasNext ?? this.hasNext,
      items: items ?? this.items,
      nextPage: nextPage ?? this.nextPage,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [hasNext, items, nextPage, filter];
}
