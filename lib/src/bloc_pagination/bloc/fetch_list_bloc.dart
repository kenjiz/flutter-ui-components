import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

part 'fetch_list_event.dart';
part 'fetch_list_state.dart';

/// Bloc that fetches a paginated list of items from an API.
///
class FetchListBloc<T> extends Bloc<FetchListEvent, FetchListState<T>> {
  FetchListBloc({
    required this.fetchListItems,
    FetchListState<T>? initialState,
    Filter? filter,
  }) : super(initialState ?? FetchListState(filter: filter, items: const [])) {
    //
    on<FetchItems>(
      _onFetchItems,
      transformer: throttleDroppable(),
    );

    add(const FetchItems());
  }

  /// Function that fetches a paginated list of items from an API.
  ///
  /// @param int `page` The page number to fetch.
  /// @param Filter `filter` The filter to apply.
  ///
  final Future<FetchedList<T>> Function(int page, Filter? filter) fetchListItems;

  /// Event handler for [FetchItems] events.
  /// It updates the state based on the event and fetches a list of items using the fetchListItems function.
  ///
  Future<void> _onFetchItems(FetchItems event, Emitter<FetchListState<T>> emit) async {
    final newFilter = event.filter ?? state.filter;
    final reset = event.refresh || event.filter != null;

    if (reset) {
      // update the filter to prevent any logical errors
      emit(
        state.copyWith(
          nextPage: 1,
          filter: newFilter,
          status: StateStatus.loading,
        ),
      );
    }

    // update the state to loading
    if (state.status != StateStatus.loading) {
      emit(state.copyWith(paginationStatus: StateStatus.loading));
    }

    try {
      // fetch the list
      final fetchedList = await fetchListItems(
        state.nextPage,
        newFilter,
      );

      if (isClosed) return;

      // update the state as empty but don't make the existing list empty
      if (fetchedList.items.isEmpty) {
        return emit(
          state.copyWith(
            status: StateStatus.empty,
            paginationStatus: StateStatus.empty,
            filter: fetchedList.filter ?? newFilter,
          ),
        );
      }
      // update the state with the list data
      emit(
        FetchListState(
          status: StateStatus.success,
          hasNext: fetchedList.hasNext,
          nextPage: fetchedList.nextPage ?? 1,
          items: reset ? fetchedList.items : state.items + fetchedList.items,
          filter: fetchedList.filter ?? newFilter,
        ),
      );
    } catch (exception) {
      // update the state as error
      if (state.items.isEmpty || reset) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            error: exception,
          ),
        );
      } else {
        emit(
          state.copyWith(
            paginationStatus: StateStatus.failure,
            error: exception,
          ),
        );
      }
    }
  }
}
