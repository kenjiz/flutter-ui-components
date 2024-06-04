import 'package:flutter_ui_components/flutter_ui_components.dart';

class FetchedList<T> {
  /// A generic class that represents a list of fetched items from an API.
  ///
  const FetchedList({
    required this.hasNext,
    required this.items,
    this.nextPage,
    this.filter,
  });

  /// {@macro hasNext}
  final bool hasNext;

  /// {@macro items}
  final List<T> items;

  /// {@macro nextPage}
  final int? nextPage;

  /// {@macro filter}
  final Filter? filter;

  FetchedList<T> operator +(FetchedList<T> other) {
    return FetchedList(
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
}
