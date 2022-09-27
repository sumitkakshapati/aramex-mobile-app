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

class AddWalletDetailsWidgets extends StatelessWidget {
  const AddWalletDetailsWidgets({Key? key}) : super(key: key);

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
              child: Container(
                margin: EdgeInsets.only(top: 20.hp),
                padding: const EdgeInsets.symmetric(
                    horizontal: CustomTheme.symmetricHozPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.addWalletDetails.tr(),
                      style: _textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.hp),
                    CustomTextField(
                      label: LocaleKeys.selectWallet.tr(),
                      hintText: "Esewa",
                      readOnly: true,
                      suffixIcon: Icons.keyboard_arrow_down_rounded,
                    ),
                    CustomTextField(
                      label: LocaleKeys.walletID.tr(),
                      hintText: "eg. Sumit Kakshapati",
                    ),
                    SizedBox(height: 20.hp),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
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
                              onPressed: () {
                                NavigationService.pop();
                              },
                            ),
                          ),
                          SizedBox(width: 20.wp),
                          Expanded(
                            child: CustomRoundedButtom(
                              title: "Save Account",
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
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
