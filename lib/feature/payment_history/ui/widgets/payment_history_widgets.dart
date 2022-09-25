import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/constant/locale_keys.dart';
import 'package:boilerplate/common/navigation/navigation_service.dart';
import 'package:boilerplate/common/route/routes.dart';
import 'package:boilerplate/common/widget/custom_app_bar.dart';
import 'package:boilerplate/feature/payment_history/ui/widgets/payment_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaymentHistoryWidgets extends StatelessWidget {
  const PaymentHistoryWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.paymentHistory.tr(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService.pushNamed(routeName: Routes.requestPay);
        },
        backgroundColor: CustomTheme.primaryColor,
        child: const Icon(
          Icons.add_rounded,
          size: 20,
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return const PaymentCard(
              horizontalMargin: CustomTheme.symmetricHozPadding,
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
