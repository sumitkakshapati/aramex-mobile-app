import 'package:aramex/feature/account_payment/cubit/user_wallet_list_cubit.dart';
import 'package:aramex/feature/account_payment/ui/widgets/account_payment_widgets.dart';
import 'package:aramex/feature/request_pay/cubit/bank_account_list_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/save_bank_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/save_wallet_cubit.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPaymentScreens extends StatelessWidget {
  const AccountPaymentScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BankAccountListCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
            saveBankCubit: BlocProvider.of<SaveBankCubit>(context),
          ),
        ),
        BlocProvider(
          create: (context) => UserWalletListCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
            saveWalletCubit: BlocProvider.of<SaveWalletCubit>(context),
          ),
        ),
      ],
      child: const AccountPaymentWidgets(),
    );
  }
}
