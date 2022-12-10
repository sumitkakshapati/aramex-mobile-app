import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteBankAccountCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;
  DeleteBankAccountCubit({required this.accountRepository})
      : super(CommonInitialState());

  deleteAccount({required int bankAccountId}) async {
    emit(CommonLoadingState());
    final _res =
        await accountRepository.deleteBankAccount(bankAccountId: bankAccountId);
    if (_res.status == Status.Success) {
      emit(CommonDataSuccessState());
    } else {
      emit(CommonErrorState(
          message: _res.message ?? "Unable to delete account"));
    }
  }
}
