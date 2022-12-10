import 'package:aramex/feature/account_payment/ui/widgets/account_payment_widgets.dart';
import 'package:aramex/feature/request_pay/cubit/bank_account_list_cubit.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPaymentScreens extends StatelessWidget {
  const AccountPaymentScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BankAccountListCubit(
        accountRepository: RepositoryProvider.of<AccountRepository>(context),
      ),
      child: const AccountPaymentWidgets(),
    );
  }
}
