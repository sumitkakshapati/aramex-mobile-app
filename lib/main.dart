import 'dart:async';

import 'package:aramex/app/app_prod.dart';
import 'package:aramex/app/local_wrapper.dart';
import 'package:aramex/common/constant/env.dart';
import 'package:aramex/common/util/log.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    runApp(
      LocalWrapper(child: AppProd(env: EnvValue.production)),
    );
  }, (e, s) {
    Log.e(e);
    Log.d(s);
  });
}
