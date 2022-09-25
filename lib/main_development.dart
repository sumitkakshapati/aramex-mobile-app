import 'dart:async';

import 'package:aramex/app/app_dev.dart';
import 'package:aramex/app/local_wrapper.dart';
import 'package:aramex/common/constant/env.dart';
import 'package:aramex/common/util/log.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// entrypoint to app in dev mode
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  /// use run zoned to catch all uncaught exceptions
  runZonedGuarded(() {
    runApp(
      LocalWrapper(child: AppDev(env: EnvValue.development)),
    );
  }, (e, s) {
    Log.e(e);
    Log.d(s);
  });
}
