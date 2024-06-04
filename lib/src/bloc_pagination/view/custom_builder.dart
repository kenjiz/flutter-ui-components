import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

class CustomBuilder<B extends BlocBase<S>, S extends FetchListState, E extends FetchListEvent> extends StatelessWidget {
  /// Generic widget class designed to build UI based on the state of the bloc.
  ///
  /// B -> Type of Bloc
  /// S -> Type of State, should extends [FetchListState]
  /// E -> Type of Event, should extends [FetchListEvent]
  ///
  const CustomBuilder({
    required this.successWidgetBuilder,
    this.listener,
    this.buildWhen,
    this.onRefresh,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    super.key,
  });

  /// Builds the widget to be displayed when the state is in a success state.
  final Widget Function(BuildContext) successWidgetBuilder;

  /// A callback function that gets called whenever a bloc event is added.
  final void Function(BuildContext, S)? listener;

  /// Callback for the conditions to restrict when to rebuild the UI
  final BlocBuilderCondition<S>? buildWhen;

  /// Callback for the refresh action
  final VoidCallback? onRefresh;

  /// Widget builder for the loading state
  final Widget? loadingWidget;

  /// Widget builder for the error state
  final Widget? errorWidget;

  /// Widget builder for the empty state
  final Widget? emptyWidget;

  Widget builder(BuildContext context, S state) {
    return switch (state.status) {
      StateStatus.loading => loadingWidget ?? const DefaultLoadingWidget(),
      StateStatus.success => successWidgetBuilder(context),
      StateStatus.failure => errorWidget ?? const DefaultErrorWidget(),
      StateStatus.empty => emptyWidget ?? const DefaultEmptyWidget(),
    };
  }

  @override
  Widget build(BuildContext context) {
    if (listener != null) {
      return BlocConsumer<B, S>(
        buildWhen: buildWhen,
        builder: builder,
        listener: listener!,
      );
    }
    return BlocBuilder<B, S>(
      builder: builder,
      buildWhen: buildWhen,
    );
  }
}
