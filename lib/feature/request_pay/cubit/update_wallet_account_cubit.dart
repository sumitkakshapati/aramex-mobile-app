import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/account_payment/model/user_wallet.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateWalletAccountCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;
  UpdateWalletAccountCubit({required this.accountRepository})
      : super(CommonInitialState());

  updateWalletAccount({
    required int userWalletId,
    required String username,
    required int walletId,
  }) async {
    emit(CommonLoadingState());
    final _res = await accountRepository.updateUserWallet(
      userWalletId: userWalletId,
      walletId: walletId,
      username: username,
    );
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataSuccessState<UserWallet>(data: _res.data));
    } else {
      emit(CommonErrorState(message: _res.message ?? "Unable to update wallet"));
    }
  }
}
