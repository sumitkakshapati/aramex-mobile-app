import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/assets.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

showRequestConfirmDialog({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const _RequestConfirmWidget();
    },
  );
}

class _RequestConfirmWidget extends StatelessWidget {
  const _RequestConfirmWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.only(
            top: 10,
            left: CustomTheme.symmetricHozPadding,
            right: CustomTheme.symmetricHozPadding,
            bottom: 20,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.hp),
                  Image.asset(
                    Assets.okBro,
                    height: 200,
                  ),
                  SizedBox(height: 14.hp),
                  Text(
                    LocaleKeys.requestConfirmed.tr(),
                    textAlign: TextAlign.center,
                    style: _textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16.hp),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: LocaleKeys.yourPaymentRequestWillBe.tr(),
                        style: _textTheme.headline6!.copyWith(
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: " ${LocaleKeys.reviewed.tr()} ",
                            style: _textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: _theme.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: LocaleKeys.byOurTeamAndDeliveriedWithIn.tr(),
                          ),
                          TextSpan(
                            text: " ${LocaleKeys.twentyFourHours.tr()} ",
                            style: _textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: _theme.primaryColor,
                              height: 1.5,
                            ),
                          ),
                          TextSpan(
                            text: LocaleKeys.ofRequestedTimeFrame.tr(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.hp),
                  CustomRoundedButtom(
                    title: LocaleKeys.done.tr(),
                    onPressed: () {
                      NavigationService.popUntilFirstPage();
                    },
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 5.hp,
                child: Align(
                  child: CustomIconButton(
                    icon: Icons.close_rounded,
                    backgroundColor: CustomTheme.lightestGray,
                    iconColor: CustomTheme.darkGray,
                    onPressed: () {
                      NavigationService.popUntilFirstPage();
                    },
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
