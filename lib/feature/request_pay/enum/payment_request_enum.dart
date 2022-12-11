enum PaymentRequestOption {
  Cash('cash'),
  BankTransfer('bank_transfer'),
  WalletTransfer('wallet_transfer');

  final String value;
  const PaymentRequestOption(this.value);

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
