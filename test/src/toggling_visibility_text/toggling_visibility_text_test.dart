import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

import '../../helper/setup_material_app.dart';

void main() {
  const text = 'Hello, World!';

  testWidgets('should the default behavior is working', (WidgetTester tester) async {
    await setupMaterialApp(
      tester,
      const TogglingVisibilityText(text: text),
    );

    expect(find.byType(TogglingVisibilityText), findsOneWidget);

    final iconFinder = find.byType(Icon);
    expect(iconFinder, findsOneWidget);

    final textFinder = find.byType(Text);
    expect(textFinder, findsOneWidget);

    expect(find.text('••••••••••ld!'), findsOneWidget);

    await tester.tap(iconFinder);
    await tester.pumpAndSettle();

    expect(find.text(text), findsOneWidget);
  });

  testWidgets('should set the visible character correctly', (WidgetTester tester) async {
    await setupMaterialApp(
      tester,
      const TogglingVisibilityText(text: text, visibleCharacterCount: 5),
    );

    expect(find.text('••••••••orld!'), findsOneWidget);
  });

  testWidgets('should properly use the mask character', (WidgetTester tester) async {
    await setupMaterialApp(
      tester,
      const TogglingVisibilityText(text: text, maskCharacter: '-'),
    );

    expect(find.text('----------ld!'), findsOneWidget);
  });

  testWidgets('should the direction changed when direction is set', (WidgetTester tester) async {
    await setupMaterialApp(
      tester,
      const TogglingVisibilityText(
        text: text,
        direction: MaskDirection.right,
      ),
    );

    expect(find.text('Hel••••••••••'), findsOneWidget);
  });

  testWidgets('should set the other property properly', (WidgetTester tester) async {
    await setupMaterialApp(
      tester,
      const TogglingVisibilityText(
        text: text,
        mainAxisAlignment: MainAxisAlignment.center,
        textStyle: TextStyle(fontSize: 20),
      ),
    );

    expect(find.byWidgetPredicate((W) => W is Row && W.mainAxisAlignment == MainAxisAlignment.center), findsOneWidget);
    expect(find.byWidgetPredicate((W) => W is Text && W.style == const TextStyle(fontSize: 20)), findsOneWidget);
  });
}
