import 'package:aramex/feature/account_payment/ui/widgets/add_bank_details_widgets.dart';
import 'package:aramex/feature/request_pay/cubit/save_bank_cubit.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBankDetailsScreens extends StatelessWidget {
  const AddBankDetailsScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SaveBankCubit(
        accountRepository: RepositoryProvider.of<AccountRepository>(context),
      ),
      child: const AddBankDetailsWidgets(),
    );
  }
}
