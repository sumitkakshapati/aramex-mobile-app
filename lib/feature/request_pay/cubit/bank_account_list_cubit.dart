import 'dart:async';

import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/request_pay/cubit/save_bank_cubit.dart';
import 'package:aramex/feature/request_pay/model/bank_account.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankAccountListCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;
  final SaveBankCubit saveBankCubit;
  StreamSubscription? _saveBankStream;

  BankAccountListCubit(
      {required this.accountRepository, required this.saveBankCubit})
      : super(CommonInitialState()) {
    _saveBankStream = saveBankCubit.stream.listen((event) {
      if (event is CommonDataSuccessState<BankAccount>) {
        _updateState();
      }
    });
  }

  _updateState() {
    emit(CommonLoadingState());
    emit(
      CommonDataFetchedState<BankAccount>(
        data: accountRepository.banksAccounts,
      ),
    );
  }

  fetchAccountList() async {
    emit(CommonLoadingState());
    final _res = await accountRepository.fetchBankAccountList();
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataFetchedState<BankAccount>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: _res.message ?? "Unable to fetch data"));
    }
  }

  @override
  Future<void> close() {
    _saveBankStream?.cancel();
    return super.close();
  }
}
