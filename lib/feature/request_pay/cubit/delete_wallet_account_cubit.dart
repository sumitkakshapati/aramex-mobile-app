import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteWalletAccountCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;
  DeleteWalletAccountCubit({required this.accountRepository})
      : super(CommonInitialState());

  deleteAccount({required int walletAccountId}) async {
    emit(CommonLoadingState());
    final _res = await accountRepository.deleteWalletAccount(
        walletAccountId: walletAccountId);
    if (_res.status == Status.Success) {
      emit(CommonDataSuccessState());
    } else {
      emit(CommonErrorState(
          message: _res.message ?? "Unable to delete account"));
    }
  }
}
