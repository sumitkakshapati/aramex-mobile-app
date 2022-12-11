import 'package:aramex/feature/account_payment/model/user_wallet.dart';

class WalletTransferData {
  final String username;
  final int? walletId;

  WalletTransferData({
    required this.username,
    required this.walletId,
  });

  factory WalletTransferData.fromUserWallet(UserWallet userWallet) {
    return WalletTransferData(
      username: userWallet.username,
      walletId: userWallet.wallet.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "wallet_id": walletId,
    };
  }
}
