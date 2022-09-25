import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/constant/locale_keys.dart';
import 'package:boilerplate/common/icons/aramex_icons.dart';
import 'package:boilerplate/common/util/size_utils.dart';
import 'package:boilerplate/common/widget/card/custom_list_tile.dart';
import 'package:boilerplate/common/widget/card_wrapper.dart';
import 'package:boilerplate/common/widget/custom_app_bar.dart';
import 'package:boilerplate/common/widget/text_field/custom_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RequestPayWidgets extends StatelessWidget {
  const RequestPayWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.requestPay.tr(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.symmetricHozPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.hp),
              DottedBorder(
                color: CustomTheme.skyBlue,
                borderType: BorderType.RRect,
                dashPattern: const [6],
                radius: const Radius.circular(12),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.wp,
                    vertical: 24.wp,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x265BCADD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.availableAmountToWithdraw.tr(),
                        style: _textTheme.headline6,
                      ),
                      SizedBox(height: 12.hp),
                      Text(
                        "75,000.35",
                        style: _textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: const Divider(height: 0),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "${LocaleKeys.note.tr()}: ",
                          style: _textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: LocaleKeys.remainingRequestPay.tr(),
                              style: _textTheme.headline6,
                            ),
                            TextSpan(
                              text: " 3/3",
                              style: _textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.hp),
              CustomTextField(
                label: LocaleKeys.requestAmountRs.tr(),
                hintText: "eg. 10000",
                bottomPadding: 32.hp,
              ),
              Text(
                LocaleKeys.paymentOptions.tr(),
                style: _textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              CardWrapper(
                bottomMargin: 24.hp,
                topMargin: 16.hp,
                verticalPadding: 4,
                child: Column(
                  children: [
                    CustomListTile(
                      title: LocaleKeys.cash.tr(),
                      icon: Iconsax.money,
                      iconColor: CustomTheme.purple,
                      showNextIcon: true,
                    ),
                    CustomListTile(
                      title: LocaleKeys.bankTransfer.tr(),
                      icon: Iconsax.bank,
                      iconColor: CustomTheme.skyBlue,
                      showNextIcon: true,
                    ),
                    CustomListTile(
                      title: LocaleKeys.walletTransfer.tr(),
                      icon: Iconsax.wallet,
                      iconColor: CustomTheme.green,
                      showBorder: false,
                      showNextIcon: true,
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "${LocaleKeys.note.tr()}: ",
                  style: _textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: LocaleKeys
                          .youCanRequestPaymentUpToNinCashinHandOptions
                          .tr(args: ["10,000.00"]),
                      style: _textTheme.headline6!,
                    )
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
