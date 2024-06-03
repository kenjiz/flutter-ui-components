import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_ui_components/flutter_ui_components.dart';

/// Default text tag.
///
abstract class TextTagCollection {
  static List<AttributedTextTag> getTextTags(TextStyle? style, void Function(String tappedText)? onTap) {
    return [
      AttributedTextTag.styled(
        name: 'highlight',
        style: style?.copyWith(color: Colors.blue),
      ),
      AttributedTextTag.styled(
        name: 'b',
        style: style?.copyWith(fontWeight: FontWeight.w600, color: style.color),
      ),
      AttributedTextTag.styled(
        name: 'error',
        style: style?.copyWith(color: Colors.red, decoration: TextDecoration.underline),
      ),
      AttributedTextTag.styled(
        name: 'warning',
        style: style?.copyWith(color: Colors.red, fontWeight: FontWeight.w700),
      ),
      AttributedTextTag.action(
        name: 'tappable',
        action: (text, _) => onTap?.call(text ?? ''),
      ),
      AttributedTextTag.action(
        name: 'action',
        action: (text, _) => onTap?.call(text ?? ''),
        style: style?.copyWith(color: Colors.blue, fontWeight: FontWeight.w500),
      ),
      AttributedTextTag.action(
        name: 'link',
        style: style?.copyWith(color: Colors.blue),
        action: (_, attrs) => attrs.values.first != null ? launchUrl(Uri.parse(attrs.values.first!)) : null,
      ),
    ];
  }
}
