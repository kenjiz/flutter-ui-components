import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:styled_text/styled_text.dart';

import 'package:flutter_ui_components/flutter_ui_components.dart';

void main() {
  group('AttributedTextTag', () {
    const name = 'test';
    action(text, attributes) {}
    const style = TextStyle(color: Colors.red);

    test('should create action tag', () {
      final tag = AttributedTextTag.action(
        name: name,
        action: action,
        style: style,
      );

      expect(tag.name, name);
      expect(tag.style, style);
      expect(tag.action, action);
      expect(tag.getTextTag(), isA<StyledTextActionTag>());
    });

    test('should create styled tag', () {
      const tag = AttributedTextTag.styled(
        name: name,
        style: style,
      );

      // then
      expect(tag.name, name);
      expect(tag.style, style);
      expect(tag.action, isNull);
      expect(tag.getTextTag(), isA<StyledTextTag>());
    });
  });
}
