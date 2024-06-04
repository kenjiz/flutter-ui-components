import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ui_components/flutter_ui_components.dart';

class CustomListView<T> extends StatelessWidget {
  const CustomListView({
    required this.itemBuilder,
    this.errorWidget,
    this.emptyWidget,
    this.loadingWidget,
    this.scrollController,
    this.paginationLoadingWidget,
    this.buildWhen,
    this.listener,
    super.key,
  });

  final Widget? errorWidget;
  final Widget? emptyWidget;
  final Widget? loadingWidget;

  /// Scroll controller for listView
  final ScrollController? scrollController;

  /// Loading widget to show when the next subsequent page is being fetched
  final Widget? paginationLoadingWidget;

  /// {@macro ItemWidgetBuilder}
  final ItemWidgetBuilder<T> itemBuilder;

  /// Condition to check if the list should be rebuilt
  final BlocBuilderCondition<FetchListState<T>>? buildWhen;

  /// Listener for state changes
  final void Function(BuildContext, FetchListState<T>)? listener;

  @override
  Widget build(BuildContext context) {
    return CustomBuilder<FetchListBloc<T>, FetchListState<T>, FetchListEvent>(
      successWidgetBuilder: (context) => PaginatedListView<T>(
        scrollController: scrollController,
        itemBuilder: itemBuilder,
        paginationLoadingWidget: paginationLoadingWidget,
      ),
      listener: listener,
      buildWhen: buildWhen,
      emptyWidget: emptyWidget,
      errorWidget: errorWidget,
      loadingWidget: loadingWidget,
      onRefresh: () => context.read<FetchListBloc<T>>().add(const FetchItems(refresh: true)),
    );
  }
}
