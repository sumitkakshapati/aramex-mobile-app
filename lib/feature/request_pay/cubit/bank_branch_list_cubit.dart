import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/request_pay/model/bank_branch.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankBranchListCubit extends Cubit<CommonState> {
  AccountRepository accountRepository;

  BankBranchListCubit({required this.accountRepository})
      : super(CommonInitialState());

  fetchBankBranchList(int bankId) async {
    emit(CommonLoadingState());
    final _res = await accountRepository.fetchBanksBranch(bankId);
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataFetchedState<BankBranch>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: _res.message ?? "Unable to fetch data"));
    }
  }
}
