import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/button/custom_outline_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/checkbox/custom_checkbox.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BankTransferRequestPayWidget extends StatefulWidget {
  const BankTransferRequestPayWidget({Key? key}) : super(key: key);

  @override
  State<BankTransferRequestPayWidget> createState() =>
      _BankTransferRequestPayWidgetState();
}

class _BankTransferRequestPayWidgetState
    extends State<BankTransferRequestPayWidget> {
  bool showAddBankOptions = false;
  bool _saveForFutureTransaction = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.requestPay.tr(),
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
                              title: "SunRise Bank",
                              description: "1234 **** **** ****",
                              descriptionFontWeight: FontWeight.w400,
                              descriptionFontSize: 14,
                              titleFontSize: 16,
                              suffixIcon: Icons.check_rounded,
                              suffixColor: _theme.primaryColor,
                              titleFontWeight: FontWeight.bold,
                              image:
                                  "https://play-lh.googleusercontent.com/bSFfTcSuDPC9EjVA5BrFpCKw38QtRT6fvBU6C5yvQ_imwY8MgUf2ZW2kJOsiwLKi4hc",
                              onPressed: () {},
                            ),
                            CustomListTile(
                              title: "NIC Asia",
                              image:
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/NIC_Asia_Bank_Logo.svg/1200px-NIC_Asia_Bank_Logo.svg.png",
                              description: "1234 **** **** ****",
                              descriptionFontWeight: FontWeight.w400,
                              descriptionFontSize: 14,
                              titleFontSize: 16,
                              titleFontWeight: FontWeight.bold,
                              showBorder: false,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            showAddBankOptions = true;
                          });
                        },
                        child: Row(
                          children: [
                            CustomIconButton(
                              icon: Icons.add_rounded,
                              iconColor: _theme.primaryColor,
                            ),
                            SizedBox(width: 20.wp),
                            Text(
                              LocaleKeys.newBank.tr(),
                              style: _textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.hp),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: showAddBankOptions
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.addBankDetails.tr(),
                                    style: _textTheme.headline3!.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 16.hp),
                                  CustomTextField(
                                    label: LocaleKeys.selectBank.tr(),
                                    hintText: "SunRise bank",
                                    readOnly: true,
                                    suffixIcon:
                                        Icons.keyboard_arrow_down_rounded,
                                  ),
                                  CustomTextField(
                                    label: LocaleKeys.accountHolderName.tr(),
                                    hintText: "eg. Sumit Kakshapati",
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
                                    title: LocaleKeys
                                        .saveAccountForFuturetransaction
                                        .tr(),
                                  ),
                                  SizedBox(height: 20.hp),
                                ],
                              )
                            : Container(),
                      ),
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
                        title: LocaleKeys.confirmRequest.tr(),
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
