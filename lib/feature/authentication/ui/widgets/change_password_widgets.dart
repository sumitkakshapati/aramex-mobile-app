import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChangePasswordWidgets extends StatelessWidget {
  const ChangePasswordWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 56.hp),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.changePassword.tr(),
                      style: _textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.hp),
                    Text(
                      LocaleKeys.youCanChangeAppPasswordFromHere.tr(),
                      style: _textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 48.hp),
                    CustomTextField(
                      label: LocaleKeys.currentPassword.tr(),
                      hintText: LocaleKeys.enterCurrentPassword.tr(),
                    ),
                    CustomTextField(
                      label: LocaleKeys.newPassword.tr(),
                      hintText: LocaleKeys.enterNewPassword.tr(),
                    ),
                    CustomTextField(
                      label: LocaleKeys.confirmPassword.tr(),
                      hintText: LocaleKeys.enterConfirmPassword.tr(),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomOutlineButton(
                            title: LocaleKeys.cancel.tr(),
                            onPressed: () {
                              NavigationService.pop();
                            },
                          ),
                        ),
                        SizedBox(width: 20.wp),
                        Expanded(
                          child: CustomRoundedButtom(
                            title: LocaleKeys.confirmChange.tr(),
                            onPressed: () {
                              NavigationService.pop();
                            },
                          ),
                        ),
                      ],
                    ),
                    SafeArea(child: SizedBox(height: 20.hp)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
