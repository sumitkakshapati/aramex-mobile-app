import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/constant/locale_keys.dart';
import 'package:boilerplate/common/navigation/navigation_service.dart';
import 'package:boilerplate/common/route/routes.dart';
import 'package:boilerplate/common/widget/button/custom_icon_button.dart';
import 'package:boilerplate/common/widget/button/rounded_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationWidgets extends StatelessWidget {
  const VerificationWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Center(
          child: CustomIconButton(
            icon: Icons.keyboard_arrow_left_rounded,
            onPressed: () {
              NavigationService.pop();
            },
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: CustomTheme.symmetricHozPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 54, bottom: 8),
              child: Text(
                LocaleKeys.verifyOTP.tr(),
                style: _textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              LocaleKeys.pleaseEnter4DigitOTP.tr(),
              style: _textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 48),
            PinCodeTextField(
              length: 4,
              appContext: context,
              animationType: AnimationType.fade,
              cursorColor: CustomTheme.primaryColor,
              mainAxisAlignment: MainAxisAlignment.start,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 58,
                fieldWidth: 58,
                fieldOuterPadding: const EdgeInsets.only(right: 24),
                activeFillColor: Colors.white,
                activeColor: CustomTheme.primaryColor,
                inactiveColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedFillColor: Colors.white,
                selectedColor: CustomTheme.primaryColor,
              ),
              enableActiveFill: true,
              onChanged: (value) {},
            ),
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                text: LocaleKeys.didntReceiveAnyCode.tr(),
                style: _textTheme.headline6,
                children: [
                  TextSpan(
                    text:
                        " ${LocaleKeys.resend.tr()} 48 ${LocaleKeys.sec.tr()}",
                    style: _textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: CustomTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomRoundedButtom(
              title: LocaleKeys.verifyOTP.tr(),
              onPressed: () {
                NavigationService.pushNamedAndRemoveUntil(
                  routeName: Routes.dashboard,
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).viewPadding.bottom > 0
                  ? MediaQuery.of(context).viewPadding.bottom + 10
                  : 20,
            )
          ],
        ),
      ),
    );
  }
}
