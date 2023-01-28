abstract class PaymentRequestEvent {}

class FetchPaymentRequestEvent extends PaymentRequestEvent {
  final String? status;

  FetchPaymentRequestEvent({this.status});
}

class LoadMorePaymentRequestEvent extends PaymentRequestEvent {
  final String? status;

  LoadMorePaymentRequestEvent({this.status});
}
