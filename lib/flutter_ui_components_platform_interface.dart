import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_ui_components_method_channel.dart';

abstract class FlutterUiComponentsPlatform extends PlatformInterface {
  /// Constructs a FlutterUiComponentsPlatform.
  FlutterUiComponentsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUiComponentsPlatform _instance = MethodChannelFlutterUiComponents();

  /// The default instance of [FlutterUiComponentsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterUiComponents].
  static FlutterUiComponentsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterUiComponentsPlatform] when
  /// they register themselves.
  static set instance(FlutterUiComponentsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
