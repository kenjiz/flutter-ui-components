import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

/// Custom tag for StyledText.
///
class AttributedTextTag {
  const AttributedTextTag.action({
    required this.name,
    required this.action,
    this.style,
  });

  const AttributedTextTag.styled({
    required this.name,
    required this.style,
  }) : action = null;

  /// The name of the tag.
  final String name;

  /// Then style of the tag.
  final TextStyle? style;

  /// The action function reference when tapped.
  final void Function(String? text, Map<String?, String?> attributes)? action;

  /// Returns a [StyledTextTagBase] object based on the type of tag:
  ///
  /// if the tag is an action tag, it returns a [StyledTextActionTag] object
  /// with the provided action function and style; otherwise, it returns a [StyledTextTag] object with the provided style.
  StyledTextTagBase getTextTag() {
    return action == null ? StyledTextTag(style: style) : StyledTextActionTag(action!, style: style);
  }
}
