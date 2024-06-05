import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

class PaginatedListView<T> extends StatefulWidget {
  //
  /// Widget to display a list of items in a paginated manner.
  ///
  const PaginatedListView({
    required this.itemBuilder,
    this.scrollController,
    this.paginationLoadingWidget,
    super.key,
  });

  /// {@macro ItemWidgetBuilder}
  final ItemWidgetBuilder<T> itemBuilder;

  /// Scroll controller for listView
  final ScrollController? scrollController;

  /// Loading widget to show when the next subsequent page is being fetched
  final Widget? paginationLoadingWidget;

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  late final FetchListBloc<T> fetchListBloc;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    fetchListBloc = context.read<FetchListBloc<T>>();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients &&
        _scrollController.position.maxScrollExtent == _scrollController.offset &&
        fetchListBloc.state.hasNext &&
        fetchListBloc.state.paginationStatus != StateStatus.loading &&
        // if an error occurs in pagination then stop further
        // pagination calls
        fetchListBloc.state.error == null) {
      fetchListBloc.add(const FetchItems());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FetchListBloc<T>, FetchListState<T>, int>(
      bloc: fetchListBloc,
      selector: (state) => state.list.items.length,
      builder: (context, length) {
        return RefreshIndicator.adaptive(
          onRefresh: () async => fetchListBloc.add(const FetchItems(refresh: true)),
          child: ListView.builder(
            itemCount: length + 1,
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == length) {
                return BlocSelector<FetchListBloc<T>, FetchListState<T>, StateStatus>(
                  selector: (state) => state.paginationStatus,
                  builder: (context, status) {
                    switch (status) {
                      case StateStatus.loading:
                        return widget.paginationLoadingWidget ?? const DefaultLoadingWidget();
                      case StateStatus.failure:
                        return const DefaultErrorWidget();
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                );
              }

              return widget.itemBuilder(
                context,
                index,
                fetchListBloc.state.list.items[index],
              );
            },
          ),
        );
      },
    );
  }
}
