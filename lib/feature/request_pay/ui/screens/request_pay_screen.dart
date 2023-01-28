import 'package:aramex/feature/request_pay/cubit/fetch_payment_info_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/payment_request_cubit.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:aramex/feature/request_pay/ui/widgets/request_pay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestPayScreens extends StatelessWidget {
  const RequestPayScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaymentRequestCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => FetchPaymentInfoCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
      ],
      child: const RequestPayWidgets(),
    );
  }
}
