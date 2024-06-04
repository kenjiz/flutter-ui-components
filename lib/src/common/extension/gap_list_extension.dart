// Gap extension on list of widget
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// This extension allows you to add gaps between widgets in a list,
/// customizing the gap and its position.
extension GapListExtension on List<Widget> {
  List<Widget> addEqualGaps({
    required Gap gap,
    bool addToLast = false,
    Gap? startGap,
    Gap? endGap,
  }) {
    final childrenWithGap = <Widget>[];
    final children = this;
    for (var i = 0; i < length; i++) {
      childrenWithGap.add(children[i]);
      if (i < length - 1) {
        childrenWithGap.add(gap);
      }
    }

    if (startGap != null) {
      childrenWithGap.insert(0, startGap);
    }

    if (endGap != null && !addToLast) {
      childrenWithGap.add(endGap);
    }

    if (addToLast) {
      // if lastGap has value, use that instead
      final lastGap = endGap ?? gap;
      // making sure it's at last index
      childrenWithGap.add(lastGap);
    }

    return childrenWithGap;
  }
}
