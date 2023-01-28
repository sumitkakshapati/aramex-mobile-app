import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

showConfirmationDialog({
  required BuildContext context,
  required VoidCallback onPressed,
  required String amount,
  required String method,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return ConfirmationPaymentRequest(
        onPressed: onPressed,
        amount: amount,
        method: method,
      );
    },
  );
}

class ConfirmationPaymentRequest extends StatelessWidget {
  final VoidCallback onPressed;
  final String amount;
  final String method;
  const ConfirmationPaymentRequest({
    super.key,
    required this.onPressed,
    required this.amount,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Dialog(
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
                Text(
                  LocaleKeys.paymentRequest.tr(),
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
                      text: LocaleKeys.doYouWantToRequestForNAmountInN
                          .tr(args: [amount, method]),
                      style: _textTheme.headline6!.copyWith(
                        height: 1.5,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.hp),
                CustomRoundedButtom(
                  title: LocaleKeys.confirm.tr(),
                  onPressed: onPressed,
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
                    NavigationService.pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
