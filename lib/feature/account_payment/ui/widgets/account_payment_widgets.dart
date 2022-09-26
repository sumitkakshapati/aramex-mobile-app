import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AccountPaymentWidgets extends StatelessWidget {
  const AccountPaymentWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.accountPayment.tr(),
      ),
      body: Container(),
    );
  }
}