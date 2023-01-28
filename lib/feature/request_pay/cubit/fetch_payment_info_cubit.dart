import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/request_pay/model/payment_request_info.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchPaymentInfoCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;
  FetchPaymentInfoCubit({required this.accountRepository})
      : super(CommonInitialState());

  fetchPaymentInfo() async {
    emit(CommonLoadingState());
    final _res = await accountRepository.requestPaymentInfo();
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataSuccessState<PaymentRequestInfo>(data: _res.data));
    } else {
      emit(CommonErrorState(
          message: _res.message ?? "Unable to fetch payment info"));
    }
  }
}
