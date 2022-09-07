import 'dart:async';

import 'package:boilerplate/app/app_prod.dart';
import 'package:boilerplate/app/local_wrapper.dart';
import 'package:boilerplate/common/constant/env.dart';
import 'package:boilerplate/common/util/log.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runZonedGuarded(() {
    runApp(
      LocalWrapper(child: AppProd(env: EnvValue.production)),
    );
  }, (e, s) {
    Log.e(e);
    Log.d(s);
  });
}
