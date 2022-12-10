import 'package:aramex/feature/account_payment/ui/widgets/add_bank_details_widgets.dart';
import 'package:aramex/feature/request_pay/model/bank_account.dart';
import 'package:flutter/material.dart';

class AddBankDetailsScreens extends StatelessWidget {
  final BankAccount? bankAccount;
  const AddBankDetailsScreens({Key? key, this.bankAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddBankDetailsWidgets(bankAccount: bankAccount);
  }
}
