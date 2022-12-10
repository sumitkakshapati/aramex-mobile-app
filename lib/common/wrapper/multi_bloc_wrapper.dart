import 'package:aramex/common/constant/env.dart';
import 'package:aramex/feature/authentication/cubit/email_login_cubit.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/dashboard/cubit/shipment_cities_cubit.dart';
import 'package:aramex/feature/dashboard/resources/shipment_repository.dart';
import 'package:aramex/feature/request_pay/cubit/bank_branch_list_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/bank_list_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/delete_bank_account_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/delete_wallet_account_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/save_bank_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/save_wallet_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/update_bank_account_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/update_wallet_account_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/wallet_list_cubit.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  final Env env;
  const MultiBlocWrapper({required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmailLoginCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => ShipmentCitiesCubit(
            shipmentRepository:
                RepositoryProvider.of<ShipmentRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => BankListCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => SaveWalletCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => SaveBankCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => BankBranchListCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => WalletListCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => DeleteBankAccountCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => DeleteWalletAccountCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateWalletAccountCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateBankAccountCubit(
            accountRepository:
                RepositoryProvider.of<AccountRepository>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}
