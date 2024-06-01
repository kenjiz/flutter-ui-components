
import 'flutter_ui_components_platform_interface.dart';

class FlutterUiComponents {
  Future<String?> getPlatformVersion() {
    return FlutterUiComponentsPlatform.instance.getPlatformVersion();
  }
}
