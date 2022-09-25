import 'package:aramex/app/theme.dart';
import 'package:aramex/app/update_wrapper.dart';
import 'package:aramex/common/constant/env.dart';
import 'package:aramex/common/constant/strings.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/route_generator.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/widget/global_error_widget.dart';
import 'package:aramex/common/wrapper/multi_bloc_wrapper.dart';
import 'package:aramex/common/wrapper/multi_repository_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppProd extends StatefulWidget {
  final Env env;
  const AppProd({Key? key, required this.env}) : super(key: key);

  @override
  _AppProdState createState() => _AppProdState();
}

class _AppProdState extends State<AppProd> {
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
          builder: (context, Widget? widget) {
            setErrorBuilder(context);
            return widget!;
          },
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          darkTheme: CustomTheme.lightTheme,
          theme: CustomTheme.lightTheme,
          title: Strings.APP_TITLE,
          initialRoute: Routes.root,
          onGenerateRoute: RouteGenerator.generateRoute,
        )),
      ),
    );
  }
}
