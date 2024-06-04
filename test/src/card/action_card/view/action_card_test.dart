import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

import '../../../../helper/setup_material_app.dart';

void main() {
  testWidgets('should properly show the widget', (WidgetTester tester) async {
    await setupMaterialApp(
      tester,
      Column(
        children: [
          ActionCard(
            icon: const Icon(Icons.add),
            caption: 'Test',
            onPressed: () {},
            dimension: 100.0,
            enabled: true,
            elevation: 10.0,
          ),
          ActionCard.expanded(
            icon: const Icon(Icons.settings),
            caption: 'Test2',
            onPressed: () {},
            enabled: true,
            elevation: 10.0,
          ),
        ],
      ),
    );

    expect(find.byType(ActionCard), findsNWidgets(2));
    expect(find.byType(Icon), findsNWidgets(2));
    expect(find.text('Test'), findsOneWidget);
    expect(find.text('Test2'), findsOneWidget);
  });

  testWidgets('should find Expanded on ActionCard.expanded', (WidgetTester tester) async {
    await setupMaterialApp(
      tester,
      const Column(
        children: [
          ActionCard.expanded(
            icon: Icon(Icons.settings),
            caption: 'test',
          ),
        ],
      ),
    );

    expect(find.byType(Expanded), findsOneWidget);
  });

  testWidgets('should find SizedBox.square on ActionCard', (WidgetTester tester) async {
    await setupMaterialApp(
      tester,
      const ActionCard(
        icon: Icon(Icons.settings),
        caption: 'test',
        dimension: 300,
      ),
    );

    final sizedBox =
        find.byWidgetPredicate((widget) => widget is SizedBox && widget.width == widget.height && widget.width == 300);

    expect(sizedBox, findsOneWidget);
  });
}
