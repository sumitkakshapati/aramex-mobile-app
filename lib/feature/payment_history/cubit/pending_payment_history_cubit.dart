import 'dart:async';

import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/payment_history/cubit/cancel_payment_request_cubit.dart';
import 'package:aramex/feature/payment_history/model/payment_request.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingPaymentHistoryCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;
  final CancelPaymentRequestCubit cancelPaymentRequestCubit;
  StreamSubscription? cancenlPaymentRequestSubcription;
  PendingPaymentHistoryCubit({
    required this.accountRepository,
    required this.cancelPaymentRequestCubit,
  }) : super(CommonInitialState()) {
    cancenlPaymentRequestSubcription =
        cancelPaymentRequestCubit.stream.listen((event) {
      if (event is CommonDataSuccessState) {
        fetchCancelledRequest();
      }
    });
  }

  fetchCancelledRequest() async {
    emit(CommonLoadingState());
    final _res = await accountRepository.fetchAllPendingRequestPayment();
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataFetchedState<PaymentRequest>(data: _res.data!));
    } else {
      emit(CommonErrorState(
          message: _res.message ?? "Unable to fetch payment request"));
    }
  }

  @override
  Future<void> close() {
    cancenlPaymentRequestSubcription?.cancel();
    return super.close();
  }
}
