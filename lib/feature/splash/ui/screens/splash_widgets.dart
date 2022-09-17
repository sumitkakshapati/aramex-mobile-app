import 'package:boilerplate/common/navigation/navigation_service.dart';
import 'package:boilerplate/common/route/routes.dart';
import 'package:boilerplate/common/widget/page_wrapper.dart';
import 'package:boilerplate/feature/splash/cubit/startup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return BlocListener<StartupCubit, StartupState>(
      listener: (context, state) {
        if (state is StartupSuccess) {
          if (state.isFirstTime) {
            NavigationService.pushReplacementNamed(
              routeName: Routes.dashboard,
            );
          } else {
            NavigationService.pushReplacementNamed(routeName: Routes.dashboard);
          }
        }
      },
      child: PageWrapper(
        showAppBar: false,
        body: Container(
          child: Center(
            child: Text(
              "Splash",
              style: _textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }
}
