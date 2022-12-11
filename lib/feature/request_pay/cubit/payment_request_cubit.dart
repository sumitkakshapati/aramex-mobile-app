import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/request_pay/enum/payment_request_enum.dart';
import 'package:aramex/feature/request_pay/model/bank_transter_data.dart';
import 'package:aramex/feature/request_pay/model/wallet_transfer_data.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentRequestCubit extends Cubit<CommonState> {
  final AccountRepository accountRepository;
  PaymentRequestCubit({required this.accountRepository})
      : super(CommonInitialState());

  requestPayment({
    required double amount,
    required PaymentRequestOption option,
    required BankTransferData? bankTransferData,
    required WalletTransferData? walletTransferData,
  }) async {
    emit(CommonLoadingState());
    final _res = await accountRepository.requestPayment(
        amount: amount,
        option: option,
        bankTransferData: bankTransferData,
        walletTransferData: walletTransferData);
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonDataSuccessState(data: _res.data));
    } else {
      emit(CommonErrorState(
          message: _res.message ?? "Unable to request payment"));
    }
  }
}
