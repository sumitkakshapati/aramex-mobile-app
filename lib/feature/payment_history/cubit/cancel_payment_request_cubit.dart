import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelPaymentRequestCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;
  CancelPaymentRequestCubit({required this.accountRepository})
      : super(CommonInitialState());

  cancelRequest(int paymentReqId) async {
    emit(CommonLoadingState());
    final _res =
        await accountRepository.cancelPaymentRequest(paymentId: paymentReqId);
    if (_res.status == Status.Success) {
      SnackBarUtils.showSuccessBar(
        context: NavigationService.context,
        message: "Payment Request Cancelled Successfully",
      );
      emit(CommonDataSuccessState());
    } else {
      final _message = _res.message ?? "Unable to delete payment reqeust";
      SnackBarUtils.showErrorBar(
        context: NavigationService.context,
        message: _message,
      );
      emit(
        CommonErrorState(message: _message),
      );
    }
  }
}
