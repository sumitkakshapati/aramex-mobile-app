import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/app/update_wrapper.dart';
import 'package:boilerplate/common/constant/env.dart';
import 'package:boilerplate/common/constant/strings.dart';
import 'package:boilerplate/common/navigation/navigation_service.dart';
import 'package:boilerplate/common/route/route_generator.dart';
import 'package:boilerplate/common/route/routes.dart';
import 'package:boilerplate/common/wrapper/multi_bloc_wrapper.dart';
import 'package:boilerplate/common/wrapper/multi_repository_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppDev extends StatefulWidget {
  final Env env;
  const AppDev({Key? key, required this.env}) : super(key: key);

  @override
  _AppDevState createState() => _AppDevState();
}

class _AppDevState extends State<AppDev> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryWrapper(
      env: widget.env,
      child: MultiBlocWrapper(
        env: widget.env,
        child: UpdateWrapper(
          child: MaterialApp(
            locale: context.locale,
            navigatorKey: NavigationService.navigationKey,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: true,
            darkTheme: CustomTheme.lightTheme,
            theme: CustomTheme.lightTheme,
            title: Strings.APP_TITLE,
            initialRoute: Routes.root,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
        ),
      ),
    );
  }
}
