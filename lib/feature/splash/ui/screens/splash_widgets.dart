import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/constant/locale_keys.dart';
import 'package:boilerplate/common/navigation/navigation_service.dart';
import 'package:boilerplate/common/route/routes.dart';
import 'package:boilerplate/common/util/device_utils.dart';
import 'package:boilerplate/common/widget/page_wrapper.dart';
import 'package:boilerplate/feature/authentication/ui/screens/register_screens.dart';
import 'package:boilerplate/feature/authentication/ui/screens/verification_screens.dart';
import 'package:boilerplate/feature/splash/cubit/startup_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashWidget extends StatefulWidget {
  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  String _appVersion = "";

  @override
  void initState() {
    super.initState();
    _fetchAppVersion();
  }

  _fetchAppVersion() async {
    _appVersion = await DeviceUtils.appVersion;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return BlocListener<StartupCubit, StartupState>(
      listener: (context, state) {
        if (state is StartupSuccess) {
          // if (state.isFirstTime) {
          //   NavigationService.pushReplacementNamed(
          //     routeName: Routes.dashboard,
          //   );
          // } else {
          //   NavigationService.pushReplacementNamed(routeName: Routes.dashboard);
          // }
          // NavigationService.pushReplacementNamed(routeName: Routes.login);
          NavigationService.push(target: RegisterScreens());
        }
      },
      child: PageWrapper(
        showAppBar: false,
        body: Container(
          child: Stack(
            children: [
              Center(
                child: Text(
                  LocaleKeys.aramex.tr().toLowerCase(),
                  style: _textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 64,
                    letterSpacing: 0.4,
                    color: CustomTheme.primaryColor,
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).viewPadding.bottom + 20,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${LocaleKeys.version.tr()} $_appVersion",
                    style: _textTheme.headline6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
