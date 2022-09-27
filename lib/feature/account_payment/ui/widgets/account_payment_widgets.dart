import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/tab/custom_tab_bar.dart';
import 'package:aramex/feature/account_payment/ui/screens/add_bank_details_screens.dart';
import 'package:aramex/feature/account_payment/ui/screens/add_wallet_details_screens.dart';
import 'package:aramex/feature/account_payment/ui/widgets/bank_tab_widget.dart';
import 'package:aramex/feature/account_payment/ui/widgets/wallet_tab_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AccountPaymentWidgets extends StatefulWidget {
  const AccountPaymentWidgets({Key? key}) : super(key: key);

  @override
  State<AccountPaymentWidgets> createState() => _AccountPaymentWidgetsState();
}

class _AccountPaymentWidgetsState extends State<AccountPaymentWidgets>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: _theme.primaryColor,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          if (tabController.index == 0) {
            NavigationService.push(target: const AddBankDetailsScreens());
          } else {
            NavigationService.push(target: const AddWalletDetailsScreens());
          }
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: Text(
                  LocaleKeys.accountPayment.tr(),
                  style: _textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                pinned: true,
                elevation: 0,
                backgroundColor: _theme.scaffoldBackgroundColor,
                leading: Center(
                  child: CustomIconButton(
                    icon: Icons.keyboard_arrow_left_rounded,
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                  ),
                ),
                bottom: CustomTabBar(
                  tabController: tabController,
                  tabs: [
                    LocaleKeys.bank.tr(),
                    LocaleKeys.wallets.tr(),
                  ],
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: const [
            BankTabWidgets(),
            WalletTabWidgets(),
          ],
        ),
      ),
    );
  }
}
