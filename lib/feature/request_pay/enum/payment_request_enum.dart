enum PaymentRequestOption {
  Cash('cash', "Cash"),
  BankTransfer('bank_transfer', "Bank Transfer"),
  WalletTransfer('wallet_transfer', "Wallet Transfer");

  final String value;
  final String formatedName;
  const PaymentRequestOption(this.value, this.formatedName);

  factory PaymentRequestOption.fromString(String value) {
    if (value == "cash") {
      return PaymentRequestOption.Cash;
    } else if (value == "bank_transfer") {
      return PaymentRequestOption.BankTransfer;
    } else {
      return PaymentRequestOption.WalletTransfer;
    }
  }
}
