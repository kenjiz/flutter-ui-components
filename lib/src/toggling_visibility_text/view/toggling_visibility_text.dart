import 'package:flutter/material.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

/// Allows the user to toggle the visibility of certain characters in a given text.
///
class TogglingVisibilityText extends StatefulWidget {
  const TogglingVisibilityText({
    required this.text,
    this.visibleCharacterCount = 3,
    this.maskCharacter = '•',
    this.direction = MaskDirection.left,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.textStyle,
    super.key,
  }) : assert(text.length >= visibleCharacterCount, 'Length of text must be greater than maskCharacterCount');

  /// The text that will be displayed.
  final String text;

  /// The number of characters that should be visible.
  final int visibleCharacterCount;

  ///  The character that will be used to mask the invisible characters.
  final String maskCharacter;

  /// The direction in which the masking will occur [MaskDirection.left] or [MaskDirection.right].
  final MaskDirection direction;

  /// The alignment of the widget within its parent.
  final MainAxisAlignment mainAxisAlignment;

  /// The style of the text.
  final TextStyle? textStyle;

  @override
  _TogglingVisibilityTextState createState() => _TogglingVisibilityTextState();
}

class _TogglingVisibilityTextState extends State<TogglingVisibilityText> {
  bool _isVisible = false;

  String get _maskCharacters {
    final text = widget.text;
    final count = widget.visibleCharacterCount;
    final maskCharacter = widget.maskCharacter;
    final mask = maskCharacter * (text.length - count);
    final start = widget.direction == MaskDirection.left ? text.length - count : 0;
    final end = widget.direction == MaskDirection.left ? text.length : count;
    return widget.direction == MaskDirection.left
        ? mask + text.substring(start, end)
        : text.substring(start, end) + mask;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.bodyMedium,
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: [
          GestureDetector(
            onTap: () => setState(() => _isVisible = !_isVisible),
            child: Icon(_isVisible ? Icons.visibility : Icons.visibility_off),
          ),
          Flexible(
            child: Text(
              _isVisible ? widget.text : _maskCharacters,
              style: widget.textStyle,
            ),
          ),
        ].addEqualGaps(gap: Gaps.s12),
      ),
    );
  }
}
