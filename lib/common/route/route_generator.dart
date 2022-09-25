import 'package:boilerplate/common/route/routes.dart';
import 'package:boilerplate/feature/authentication/ui/screens/login_screens.dart';
import 'package:boilerplate/feature/authentication/ui/screens/register_screens.dart';
import 'package:boilerplate/feature/dashboard/ui/screens/dashboard_screens.dart';
import 'package:boilerplate/feature/splash/ui/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return PageTransition(
          child: const SplashScreens(),
          type: PageTransitionType.fade,
          settings: RouteSettings(name: settings.name),
        );
      case Routes.dashboard:
        return PageTransition(
          child: const DashboardScreens(),
          type: PageTransitionType.fade,
          settings: RouteSettings(name: settings.name),
        );
      case Routes.login:
        return PageTransition(
          child: const LoginScreens(),
          type: PageTransitionType.fade,
          settings: RouteSettings(name: settings.name),
        );
      case Routes.registration:
        return PageTransition(
          child: const RegisterScreens(),
          type: PageTransitionType.fade,
          settings: RouteSettings(name: settings.name),
        );
      default:
        return PageTransition(
          child: const SplashScreens(),
          type: PageTransitionType.fade,
          settings: RouteSettings(name: settings.name),
        );
    }
  }
}
