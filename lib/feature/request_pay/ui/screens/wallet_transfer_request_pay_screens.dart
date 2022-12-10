import 'package:aramex/feature/account_payment/cubit/user_wallet_list_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/delete_wallet_account_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/save_wallet_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/update_wallet_account_cubit.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:aramex/feature/request_pay/ui/widgets/wallet_transfer_request_pay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletTransferRequestPayScreen extends StatelessWidget {
  final double requestedAmount;
  const WalletTransferRequestPayScreen(
      {Key? key, required this.requestedAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserWalletListCubit(
        accountRepository: RepositoryProvider.of<AccountRepository>(context),
        saveWalletCubit: BlocProvider.of<SaveWalletCubit>(context),
        deleteWalletAccountCubit:
            BlocProvider.of<DeleteWalletAccountCubit>(context),
        updateWalletAccountCubit:
            BlocProvider.of<UpdateWalletAccountCubit>(context),
      ),
      child: WalletTransferRequestPayWidget(requestedAmount: requestedAmount),
    );
  }
}
