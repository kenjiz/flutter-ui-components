import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

class AppImage extends ImageModel {
  const AppImage({required super.path});
}

void main() {
  Future<void> setupMaterialApp(
    WidgetTester tester,
    Widget widget,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: widget),
      ),
    );
  }

  testWidgets('should the default behavior is working', (WidgetTester tester) async {
    const image = AppImage(path: 'assets/image.png');
    await setupMaterialApp(
      tester,
      const AssetGraphic(
        image,
        color: Colors.red,
        width: 200,
        height: 300,
        fit: BoxFit.cover,
      ),
    );

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(SvgPicture), findsNothing);

    final imageWidget = tester.widget<Image>(find.byType(Image));
    expect(imageWidget.image, equals(AssetImage(image.path)));
    expect(imageWidget.color, equals(Colors.red));
    expect(imageWidget.width, equals(200));
    expect(imageWidget.height, equals(300));
    expect(imageWidget.fit, equals(BoxFit.cover));
  });

  testWidgets('should the svg behavior is working', (WidgetTester tester) async {
    const image = AppImage(path: 'assets/add.svg');
    await setupMaterialApp(
      tester,
      const AssetGraphic(
        image,
        width: 200,
        height: 300,
        color: Colors.red,
        fit: BoxFit.cover,
      ),
    );

    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(Image), findsNothing);

    final svgPictureWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(svgPictureWidget.bytesLoader, equals(SvgAssetLoader(image.path)));
    expect(svgPictureWidget.colorFilter, equals(const ColorFilter.mode(Colors.red, BlendMode.srcIn)));
    expect(svgPictureWidget.width, equals(200));
    expect(svgPictureWidget.height, equals(300));
    expect(svgPictureWidget.fit, equals(BoxFit.cover));
  });
}
