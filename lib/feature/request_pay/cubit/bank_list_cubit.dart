import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/request_pay/model/bank.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankListCubit extends Cubit<CommonState> {
  AccountRepository accountRepository;

  BankListCubit({required this.accountRepository})
      : super(CommonInitialState());

  fetchBankList() async {
    emit(CommonLoadingState());
    final _res = await accountRepository.fetchBanks();
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataFetchedState<Bank>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: _res.message ?? "Unable to fetch data"));
    }
  }
}
