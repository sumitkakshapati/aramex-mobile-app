import 'dart:async';

import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/account_payment/model/user_wallet.dart';
import 'package:aramex/feature/request_pay/cubit/delete_wallet_account_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/save_wallet_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/update_wallet_account_cubit.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserWalletListCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;
  final SaveWalletCubit saveWalletCubit;
  StreamSubscription? _saveWalletStream;
  final DeleteWalletAccountCubit deleteWalletAccountCubit;
  StreamSubscription? _deleteWalletAccountStream;
  final UpdateWalletAccountCubit updateWalletAccountCubit;
  StreamSubscription? _updateWalletAccountStream;

  UserWalletListCubit({
    required this.accountRepository,
    required this.saveWalletCubit,
    required this.deleteWalletAccountCubit,
    required this.updateWalletAccountCubit,
  }) : super(CommonInitialState()) {
    _saveWalletStream = saveWalletCubit.stream.listen((event) {
      if (event is CommonDataSuccessState<UserWallet>) {
        _updateState();
      }
    });

    _deleteWalletAccountStream =
        deleteWalletAccountCubit.stream.listen((event) {
      if (event is CommonDataSuccessState) {
        _updateState();
      }
    });

    _updateWalletAccountStream =
        updateWalletAccountCubit.stream.listen((event) {
      if (event is CommonDataSuccessState) {
        _updateState();
      }
    });
  }

  _updateState() {
    emit(CommonLoadingState());
    emit(
      CommonDataFetchedState<UserWallet>(
        data: accountRepository.userWallets,
      ),
    );
  }

  fetchUserWallet() async {
    emit(CommonLoadingState());
    final _res = await accountRepository.fetchUserWallets();
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataFetchedState<UserWallet>(data: _res.data!));
    } else {
      emit(CommonErrorState(message: _res.message ?? "Unable to fetch wallet"));
    }
  }

  @override
  Future<void> close() {
    _saveWalletStream?.cancel();
    _deleteWalletAccountStream?.cancel();
    _updateWalletAccountStream?.cancel();
    return super.close();
  }
}
