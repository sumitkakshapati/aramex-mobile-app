import 'package:aramex/common/route/routes.dart';
import 'package:aramex/feature/account_payment/ui/screens/account_payment_screens.dart';
import 'package:aramex/feature/authentication/ui/screens/change_password_screens.dart';
import 'package:aramex/feature/authentication/ui/screens/link_account_screens.dart';
import 'package:aramex/feature/authentication/ui/screens/login_screens.dart';
import 'package:aramex/feature/authentication/ui/screens/register_screens.dart';
import 'package:aramex/feature/dashboard/ui/screens/dashboard_screens.dart';
import 'package:aramex/feature/payment_history/ui/screens/payment_history_screens.dart';
import 'package:aramex/feature/profile/ui/screens/profile_details_screens.dart';
import 'package:aramex/feature/request_pay/ui/screens/request_pay_screen.dart';
import 'package:aramex/feature/splash/ui/widgets/splash_screen.dart';
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
      case Routes.requestPay:
        return PageTransition(
          child: const RequestPayScreens(),
          type: PageTransitionType.fade,
          settings: RouteSettings(name: settings.name),
        );
      case Routes.paymentHistory:
        return PageTransition(
          child: const PaymentHistoryScreens(),
          type: PageTransitionType.fade,
          settings: RouteSettings(name: settings.name),
        );
      case Routes.profileDetails:
        return PageTransition(
          child: const ProfileDetailScreens(),
          type: PageTransitionType.fade,
          settings: RouteSettings(name: settings.name),
        );
      case Routes.changePassword:
        return PageTransition(
          child: const ChangePasswordScreens(),
          type: PageTransitionType.fade,
          settings: RouteSettings(name: settings.name),
        );
      case Routes.accountPayment:
        return PageTransition(
          child: const AccountPaymentScreens(),
          type: PageTransitionType.fade,
          settings: RouteSettings(name: settings.name),
        );
      case Routes.linkAccount:
        return PageTransition(
          child: const LinkAccountScreens(),
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
