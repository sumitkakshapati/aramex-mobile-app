import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtils {
  static final DeviceUtils _deviceUtils = DeviceUtils._internal();

  factory DeviceUtils() {
    return _deviceUtils;
  }

  DeviceUtils._internal();

  static String _userAgent = "";

  static Future<String> get appVersion async {
    final _res = await PackageInfo.fromPlatform();
    return _res.version;
  }

  static Future<String> get userAgent async {
    if (_userAgent.isNotEmpty) {
      return _userAgent;
    }
    try {
      await FkUserAgent.init();
      _userAgent = FkUserAgent.userAgent ?? "";
      return _userAgent;
    } catch (e) {
      return "";
    }
  }
}
