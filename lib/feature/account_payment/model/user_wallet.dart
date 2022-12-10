import 'package:aramex/feature/account_payment/model/wallet.dart';

class UserWallet {
  final int id;
  final String username;
  final Wallet wallet;

  UserWallet({
    required this.id,
    required this.username,
    required this.wallet,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) {
    return UserWallet(
      id: json['_id'],
      username: json["username"],
      wallet: Wallet.fromJson(json["wallet"]),
    );
  }
}
