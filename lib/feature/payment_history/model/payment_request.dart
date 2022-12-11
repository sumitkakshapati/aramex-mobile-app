import 'package:aramex/common/model/media.dart';
import 'package:aramex/feature/payment_history/enum/payment_status_enum.dart';
import 'package:aramex/feature/payment_history/model/payment_bank.dart';
import 'package:aramex/feature/payment_history/model/payment_wallet.dart';
import 'package:aramex/feature/request_pay/enum/payment_request_enum.dart';

class PaymentRequest {
  final int id;
  final double amount;
  final PaymentRequestOption option;
  final Media? receipt;
  final PaymentBank? bank;
  final PaymentWallet? wallet;
  final DateTime? completedAt;
  final PaymentStatus paymentStatus;

  PaymentRequest({
    required this.id,
    required this.amount,
    required this.option,
    required this.receipt,
    required this.bank,
    required this.wallet,
    required this.completedAt,
    required this.paymentStatus,
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) {
    return PaymentRequest(
      id: json["_id"],
      amount: double.parse(json["amount"].toString()),
      option: PaymentRequestOption.fromString(json["payment_option"]),
      receipt: json["media"] != null ? Media.fromJson(json["media"]) : null,
      bank: json["bank"] != null ? PaymentBank.fromJson(json["bank"]) : null,
      wallet: json["wallet"] != null
          ? PaymentWallet.fromJson(json["wallet"])
          : null,
      completedAt: DateTime.tryParse(json["completed_at"]?.toString() ?? ""),
      paymentStatus: PaymentStatus.fromString(json["status"]),
    );
  }
}
