import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/constant/locale_keys.dart';
import 'package:boilerplate/common/navigation/navigation_service.dart';
import 'package:boilerplate/common/widget/button/custom_icon_button.dart';
import 'package:boilerplate/common/widget/button/rounded_button.dart';
import 'package:boilerplate/common/widget/text_field/custom_textfield.dart';
import 'package:boilerplate/feature/authentication/ui/screens/verification_screens.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RegisterWidgets extends StatelessWidget {
  const RegisterWidgets({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.symmetricHozPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                LocaleKeys.registerToAramex.tr(),
                style: _textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                LocaleKeys.weCoverAllKindOfTransportation.tr(),
                style: _textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 48),
                alignment: Alignment.center,
                child: DottedBorder(
                  borderType: BorderType.Circle,
                  strokeWidth: 1,
                  dashPattern: const [6],
                  color: CustomTheme.primaryColor,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(42),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.image,
                      color: CustomTheme.primaryColor,
                      size: 30,
                    ),
                  ),
                ),
              ),
              CustomTextField(
                label: LocaleKeys.accountNumber.tr(),
                hintText: "12345678",
              ),
              CustomTextField(
                label: LocaleKeys.fullName.tr(),
                hintText: "Ram Shrestha",
              ),
              CustomTextField(
                label: LocaleKeys.email.tr(),
                hintText: "******@gmail.com",
              ),
              CustomTextField(
                label: LocaleKeys.phoneNumber.tr(),
                hintText: "98xxxxxxxx",
              ),
              CustomTextField(
                label: LocaleKeys.address.tr(),
                hintText: "Enter Address",
              ),
              CustomTextField(
                label: LocaleKeys.password.tr(),
                obscureText: true,
                hintText: "******",
              ),
              CustomTextField(
                label: LocaleKeys.confirmPassword.tr(),
                obscureText: true,
                hintText: "******",
                bottomPadding: 24,
              ),
              CustomRoundedButtom(
                title: LocaleKeys.registerNow.tr(),
                onPressed: () {
                  NavigationService.push(target: const VerificationScreens());
                },
              ),
              SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 20),
            ],
          ),
        ),
      ),
    );
  }
}
