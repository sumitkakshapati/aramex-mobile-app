import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import "package:easy_localization/easy_localization.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showLogoutDialog(BuildContext context) {
  final _theme = Theme.of(context);
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(36),
      ),
    ),
    backgroundColor: _theme.scaffoldBackgroundColor,
    builder: (context) {
      return LogoutWidget();
    },
  );
}

class LogoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Material(
      shadowColor: _theme.scaffoldBackgroundColor,
      elevation: 5,
      color: _theme.scaffoldBackgroundColor,
      type: MaterialType.card,
      clipBehavior: Clip.none,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          color: _theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        ),
        padding:
            const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 4,
                width: 60,
                decoration: BoxDecoration(
                  color: CustomTheme.darkGray.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              LocaleKeys.logoutText.tr(),
              style: _textTheme.headline6!.copyWith(
                fontSize: 18,
                height: 1.2,
                color: CustomTheme.darkGray,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomRoundedButtom(
              title: LocaleKeys.logout.tr().toUpperCase(),
              onPressed: () {
                RepositoryProvider.of<UserRepository>(context).logout();
                SnackBarUtils.showSuccessBar(
                  context: context,
                  message: LocaleKeys.logoutSuccessfully.tr(),
                );
                NavigationService.pushNamedAndRemoveUntil(
                  routeName: Routes.login,
                );
              },
            ),
            const SizedBox(height: 8),
            CustomOutlineButton(
              title: LocaleKeys.cancel.tr().toUpperCase(),
              textColor: CustomTheme.darkGray,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
