import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/checkbox/custom_checkbox.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EditPaymentRequestWidgets extends StatefulWidget {
  const EditPaymentRequestWidgets({Key? key}) : super(key: key);

  @override
  State<EditPaymentRequestWidgets> createState() =>
      _EditPaymentRequestWidgetsState();
}

class _EditPaymentRequestWidgetsState extends State<EditPaymentRequestWidgets> {
  bool _saveForFutureTransaction = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.editRequests.tr(),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CustomTheme.symmetricHozPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.hp),
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
                          width: double.infinity,
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 32.hp),
                      CustomTextField(
                        label: LocaleKeys.requestableAmountRs.tr(),
                        hintText: "eg. 10000",
                        bottomPadding: 32.hp,
                      ),
                      Text(
                        LocaleKeys.receivingType.tr(),
                        style: _textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 32.hp),
                      CustomTextField(
                        label: LocaleKeys.selectBank.tr(),
                        hintText: "SunRise bank",
                        suffixIcon: Icons.keyboard_arrow_down_rounded,
                        bottomPadding: 32.hp,
                      ),
                      CustomTextField(
                        label: LocaleKeys.accountHolderName.tr(),
                        hintText: "eg. Sumit Kakshapati",
                        bottomPadding: 32.hp,
                      ),
                      CustomTextField(
                        label: LocaleKeys.accountNumber.tr(),
                        hintText: "eg. 1234 5678 9123",
                        bottomPadding: 16.hp,
                      ),
                      CustomCheckbox(
                        status: _saveForFutureTransaction,
                        onChanged: (val) {
                          setState(() {
                            _saveForFutureTransaction = val;
                          });
                        },
                        title: LocaleKeys.saveAccountForFuturetransaction.tr(),
                      ),
                      SizedBox(height: 20.hp),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: CustomTheme.symmetricHozPadding,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomOutlineButton(
                        title: LocaleKeys.cancel.tr(),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 20.wp),
                    Expanded(
                      child: CustomRoundedButtom(
                        title: LocaleKeys.saveUpdate.tr(),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
