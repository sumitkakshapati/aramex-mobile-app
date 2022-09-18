import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtils {
  static final DeviceUtils _deviceUtils = DeviceUtils._internal();

  factory DeviceUtils() {
    return _deviceUtils;
  }

  DeviceUtils._internal();

  static Future<String> get appVersion async {
    final _res = await PackageInfo.fromPlatform();
    return _res.version;
  }
}
