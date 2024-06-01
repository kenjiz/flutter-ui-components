import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_ui_components_platform_interface.dart';

/// An implementation of [FlutterUiComponentsPlatform] that uses method channels.
class MethodChannelFlutterUiComponents extends FlutterUiComponentsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_ui_components');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
