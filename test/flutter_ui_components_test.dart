import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';
import 'package:flutter_ui_components/flutter_ui_components_platform_interface.dart';
import 'package:flutter_ui_components/flutter_ui_components_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUiComponentsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterUiComponentsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterUiComponentsPlatform initialPlatform = FlutterUiComponentsPlatform.instance;

  test('$MethodChannelFlutterUiComponents is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterUiComponents>());
  });

  test('getPlatformVersion', () async {
    FlutterUiComponents flutterUiComponentsPlugin = FlutterUiComponents();
    MockFlutterUiComponentsPlatform fakePlatform = MockFlutterUiComponentsPlatform();
    FlutterUiComponentsPlatform.instance = fakePlatform;

    expect(await flutterUiComponentsPlugin.getPlatformVersion(), '42');
  });
}
