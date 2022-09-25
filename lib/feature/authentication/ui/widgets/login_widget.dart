import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginWidgets extends StatelessWidget {
  const LoginWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.symmetricHozPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).viewPadding.top + 40.hp),
              Text(
                LocaleKeys.aramex.tr().toLowerCase(),
                style: _textTheme.headline1!.copyWith(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                  color: CustomTheme.primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 48.hp, bottom: 8.hp),
                child: Text(
                  LocaleKeys.loginToAramex.tr(),
                  style: _textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              Text(
                LocaleKeys.weCoverAllKindOfTransportation.tr(),
                style: _textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 48.hp),
              CustomTextField(
                label: LocaleKeys.emailAddress.tr(),
                hintText: "******@gmail.com",
              ),
              CustomTextField(
                label: LocaleKeys.password.tr(),
                hintText: "********",
                obscureText: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${LocaleKeys.forgotPassword.tr()}?",
                  style: _textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 24.hp),
              CustomRoundedButtom(
                title: LocaleKeys.login.tr(),
                onPressed: () {
                  NavigationService.pushNamedAndRemoveUntil(
                      routeName: Routes.dashboard);
                },
              ),
              SizedBox(height: 24.hp),
              RichText(
                text: TextSpan(
                  text: "${LocaleKeys.dontHaveAnAccount.tr()}",
                  style: _textTheme.headline6,
                  children: [
                    TextSpan(
                      text: " ${LocaleKeys.registerNow.tr()}",
                      style: _textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CustomTheme.primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigationService.pushNamed(
                              routeName: Routes.registration);
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
