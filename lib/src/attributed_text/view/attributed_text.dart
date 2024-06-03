import 'package:flutter/material.dart';
import 'package:styled_text/widgets/styled_text.dart';

import 'package:flutter_ui_components/flutter_ui_components.dart';

/// Custom wrapper for StyledText.
///
/// Displays a styled text with customizable styling, alignment, and maximum number of lines.
///
class AttributedText extends StatelessWidget {
  const AttributedText({
    required this.text,
    required this.textStyle,
    this.textAlign = TextAlign.left,
    this.onTappedActionText,
    this.maxLines,
    super.key,
  });

  /// The text to display.
  final String text;

  /// The style to use for the text.
  /// See [TextStyle] for more details.
  final TextStyle? textStyle;

  /// The alignment of the text.
  /// See [TextAlign] for more details.
  final TextAlign textAlign;

  /// The action function reference when tapped.
  final void Function(String tappedText)? onTappedActionText;

  /// The maximum number of lines to display.
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final tagList = TextTagCollection.getTextTags(textStyle, onTappedActionText);
    final tags = {for (final tag in tagList) tag.name: tag.getTextTag()};

    return StyledText(
      text: text,
      tags: tags,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
