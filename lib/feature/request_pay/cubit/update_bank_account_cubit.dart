import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/request_pay/model/bank_account.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBankAccountCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;

  UpdateBankAccountCubit({required this.accountRepository})
      : super(CommonInitialState());

  updateBankAccount({
    required int bankAccountId,
    required int bankId,
    required int branchId,
    required String accountName,
    required String accountNumber,
  }) async {
    emit(CommonLoadingState());
    final _res = await accountRepository.updateBankAccount(
      bankAccountId: bankAccountId,
      bankId: bankId,
      branchId: branchId,
      accountName: accountName,
      accountNumber: accountNumber,
    );
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataSuccessState<BankAccount>(data: _res.data));
    } else {
      emit(CommonErrorState(
          message: _res.message ?? "Unable to update bank account"));
    }
  }
}
