class Config {
  num maxWalletAccount;
  num maxBankAccount;
  num maxCashWithdrawLimit;
  num maxWalletWithdrawLimit;
  num maxPaymentRequest;

  Config({
    required this.maxWalletAccount,
    required this.maxBankAccount,
    required this.maxCashWithdrawLimit,
    required this.maxWalletWithdrawLimit,
    required this.maxPaymentRequest,
  });

  factory Config.initial() {
    return Config(
      maxWalletAccount: 0,
      maxBankAccount: 0,
      maxCashWithdrawLimit: 0,
      maxWalletWithdrawLimit: 0,
      maxPaymentRequest: 0,
    );
  }

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      maxWalletAccount: json['max_wallet_account'] ?? 0,
      maxBankAccount: json['max_bank_account'] ?? 0,
      maxCashWithdrawLimit: json['max_cash_withdraw_limit'] ?? 0,
      maxWalletWithdrawLimit: json['max_wallet_withdraw_limit'] ?? 0,
      maxPaymentRequest: json['max_payment_request'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['max_wallet_account'] = maxWalletAccount;
    data['max_bank_account'] = maxBankAccount;
    data['max_cash_withdraw_limit'] = maxCashWithdrawLimit;
    data['max_wallet_withdraw_limit'] = maxWalletWithdrawLimit;
    data['max_payment_request'] = maxPaymentRequest;
    return data;
  }
}
