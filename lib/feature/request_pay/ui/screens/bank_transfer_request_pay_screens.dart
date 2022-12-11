import 'package:aramex/feature/request_pay/cubit/bank_account_list_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/delete_bank_account_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/payment_request_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/save_bank_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/update_bank_account_cubit.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:aramex/feature/request_pay/ui/widgets/bank_transfer_request_pay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankTransferRequestPayScreen extends StatelessWidget {
  final double requestedAmount;
  const BankTransferRequestPayScreen({
    Key? key,
    required this.requestedAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BankAccountListCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
            saveBankCubit: BlocProvider.of<SaveBankCubit>(context),
            deleteBankAccountCubit:
                BlocProvider.of<DeleteBankAccountCubit>(context),
            updateBankAccountCubit:
                BlocProvider.of<UpdateBankAccountCubit>(context),
          ),
        ),
        BlocProvider(
          create: (context) => PaymentRequestCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
      ],
      child: BankTransferRequestPayWidget(requestedAmount: requestedAmount),
    );
  }
}
