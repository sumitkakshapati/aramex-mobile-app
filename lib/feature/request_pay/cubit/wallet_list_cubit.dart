import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/account_payment/model/wallet.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletListCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;

  WalletListCubit({required this.accountRepository})
      : super(CommonInitialState());

  fetchWallets() async {
    emit(CommonLoadingState());
    final _res = await accountRepository.fetchWallets();
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataFetchedState<Wallet>(data: _res.data!));
    } else {
      emit(
          CommonErrorState(message: _res.message ?? "Unable to fetch wallets"));
    }
  }
}
