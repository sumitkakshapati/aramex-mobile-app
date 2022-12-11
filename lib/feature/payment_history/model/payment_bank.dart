import 'package:aramex/feature/request_pay/model/bank.dart';
import 'package:aramex/feature/request_pay/model/bank_branch.dart';

class PaymentBank {
  final String accountNumber;
  final String accountHolderName;
  final Bank bank;
  final BankBranch bankBranch;

  PaymentBank({
    required this.accountNumber,
    required this.accountHolderName,
    required this.bank,
    required this.bankBranch,
  });

  factory PaymentBank.fromJson(Map<String, dynamic> json) {
    return PaymentBank(
      accountNumber: json["account_number"],
      accountHolderName: json["account_holder_name"],
      bank: Bank.fromJson(json["bank"]),
      bankBranch: BankBranch.fromJson(json["branch"]),
    );
  }
}
