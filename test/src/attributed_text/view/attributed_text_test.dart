import 'package:flutter_ui_components/flutter_ui_components.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

void main() {
  testWidgets('should attributed text is working with all properties', (WidgetTester tester) async {
    const String text = 'Hello world!';
    const TextStyle textStyle = TextStyle(color: Colors.red);
    const TextAlign textAlign = TextAlign.center;
    const int maxLines = 2;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AttributedText(
            text: text,
            textStyle: textStyle,
            textAlign: textAlign,
            maxLines: maxLines,
          ),
        ),
      ),
    );

    expect(tester.widget<StyledText>(find.byType(StyledText)).text, text);
    expect(tester.widget<StyledText>(find.byType(StyledText)).style, textStyle);
    expect(tester.widget<StyledText>(find.byType(StyledText)).textAlign, textAlign);
    expect(tester.widget<StyledText>(find.byType(StyledText)).maxLines, maxLines);
  });
}
