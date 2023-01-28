import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/payment_history/model/payment_request.dart';
import 'package:aramex/feature/request_pay/cubit/payment_request_event.dart';
import 'package:aramex/feature/request_pay/resources/account_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPaymentRequestCubit extends Bloc<PaymentRequestEvent, CommonState> {
  final AccountRepository accountRepository;
  ListPaymentRequestCubit({required this.accountRepository})
      : super(CommonInitialState()) {
    on<FetchPaymentRequestEvent>((event, emit) async {
      emit(CommonLoadingState());
      final _res =
          await accountRepository.fetchAllRequestPayment(status: event.status);
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
    });

    on<LoadMorePaymentRequestEvent>(
      (event, emit) async {
        emit(CommonDummyLoadingState());
        final _ = await accountRepository.fetchAllRequestPayment(
          isLoadMore: true,
          status: event.status,
        );
        emit(
          CommonDataFetchedState<PaymentRequest>(
            data: accountRepository.paymentRequests,
          ),
        );
      },
      transformer: droppable(),
    );
  }
}
