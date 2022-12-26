import 'package:aramex/feature/payment_history/ui/widgets/payment_history_widgets.dart';
import 'package:aramex/feature/request_pay/cubit/list_payment_request_cubit.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentHistoryScreens extends StatelessWidget {
  const PaymentHistoryScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListPaymentRequestCubit(
        accountRepository: RepositoryProvider.of<AccountRepository>(context),
      ),
      child: const PaymentHistoryWidgets(),
    );
  }
}
