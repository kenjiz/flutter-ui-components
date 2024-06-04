import 'package:flutter/widgets.dart';

/// {@template ItemWidgetBuilder}
/// Type definition of item widget builder
/// {@endtemplate}
///
typedef ItemWidgetBuilder<T> = Widget Function(
  BuildContext context,
  int index,
  T item,
);
