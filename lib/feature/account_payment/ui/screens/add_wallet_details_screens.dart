import 'package:aramex/feature/account_payment/model/user_wallet.dart';
import 'package:aramex/feature/account_payment/ui/widgets/add_wallet_details_widgets.dart';
import 'package:flutter/material.dart';

class AddWalletDetailsScreens extends StatelessWidget {
  final UserWallet? userWallet;
  const AddWalletDetailsScreens({Key? key, this.userWallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddWalletDetailsWidgets(userWallet: userWallet);
  }
}
