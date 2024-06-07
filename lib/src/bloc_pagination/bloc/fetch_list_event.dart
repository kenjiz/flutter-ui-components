part of 'fetch_list_bloc.dart';

class FetchListEvent extends Equatable {
  //
  /// Used to represent an event that can be dispatched to a [FetchListBloc]
  /// to trigger a fetch of a paginated list from an API.
  const FetchListEvent();

  @override
  List<Object?> get props => [];
}

class FetchItems extends FetchListEvent {
  const FetchItems({
    this.refresh = false,
    this.filter,
  });

  /// Whether to fetch the first page of the list
  final bool refresh;

  /// {@macro filter}
  final Filter? filter;

  @override
  List<Object?> get props => [refresh, filter];
}
