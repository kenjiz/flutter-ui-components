part of 'fetch_list_bloc.dart';

class FetchListState<T> extends Equatable {
  //
  /// State class that holds the state of a paginated list fetched from an API.
  const FetchListState({
    required this.items,
    this.nextPage = 1,
    this.status = StateStatus.loading,
    this.paginationStatus = StateStatus.empty,
    this.hasNext = false,
    this.error,
    this.filter,
  });

  /// {@template hasNext}
  /// A boolean indicating whether there are more items on the next page of the list.
  /// {@endtemplate}
  final bool hasNext;

  /// {@template nextPage}
  /// An integer representing the page number to fetch in the next API call.
  /// {@endtemplate}
  final int nextPage;

  /// {@template items}
  /// A list of [T] items fetched from the API.
  /// {@endtemplate}
  final List<T> items;

  /// {@template status}
  /// A [StateStatus] enum indicating the status of the API call (loading, success, failure, or empty).
  /// {@endtemplate}
  final StateStatus status;

  /// {@template error}
  /// An optional error object if the API call failed.
  /// {@endtemplate}
  final Object? error;

  /// {@template filter}
  /// An optional [Filter] object used to fetch the list.
  /// Value should extend the abstract class [Filter].
  /// {@endtemplate}
  final Filter? filter;

  /// {@template paginationStatus}
  /// A [StateStatus] enum indicating the status of the latest subsequent page API call.
  /// {@endtemplate}
  final StateStatus paginationStatus;

  String get errorMessage {
    if (error is Exception) return error.toString();
    return 'Something went wrong';
  }

  @override
  List<Object?> get props {
    return [
      hasNext,
      nextPage,
      items,
      status,
      error,
      filter,
      paginationStatus,
    ];
  }

  FetchListState<T> copyWith({
    bool? hasNext,
    int? nextPage,
    List<T>? items,
    StateStatus? status,
    Object? error,
    Filter? filter,
    StateStatus? paginationStatus,
  }) {
    return FetchListState<T>(
      hasNext: hasNext ?? this.hasNext,
      nextPage: nextPage ?? this.nextPage,
      items: items ?? this.items,
      status: status ?? this.status,
      error: error ?? this.error,
      filter: filter ?? this.filter,
      paginationStatus: paginationStatus ?? this.paginationStatus,
    );
  }
}
