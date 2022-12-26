import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/payment_history/model/payment_request.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPaymentRequestCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;
  ListPaymentRequestCubit({required this.accountRepository})
      : super(CommonInitialState());

  fetchData() async {
    final _res = await accountRepository.fetchAllRequestPayment();
    if (_res.status == Status.Success && _res.data != null) {
      emit(
        CommonDataFetchedState<PaymentRequest>(data: _res.data!),
      );
    } else {
      emit(
        CommonErrorState(
            message: _res.message ?? "Unable to load payment request"),
      );
    }
  }
}
