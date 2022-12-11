import 'package:aramex/feature/account_payment/model/wallet.dart';

class PaymentWallet {
  final String userName;
  final Wallet wallet;

  PaymentWallet({
    required this.userName,
    required this.wallet,
  });

  factory PaymentWallet.fromJson(Map<String, dynamic> json) {
    return PaymentWallet(
      userName: json["username"],
      wallet: Wallet.fromJson(json["wallet"]),
    );
  }
}
