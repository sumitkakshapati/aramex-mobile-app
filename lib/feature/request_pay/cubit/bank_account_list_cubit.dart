import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/request_pay/model/bank_account.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankAccountListCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;

  BankAccountListCubit({required this.accountRepository})
      : super(CommonInitialState());

  fetchAccountList() async {
    emit(CommonLoadingState());
    final _res = await accountRepository.fetchBankAccountList();
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataFetchedState<BankAccount>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: _res.message ?? "Unable to fetch data"));
    }
  }
}
