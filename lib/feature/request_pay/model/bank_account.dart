import 'package:aramex/feature/request_pay/model/bank.dart';
import 'package:aramex/feature/request_pay/model/bank_branch.dart';

class BankAccount {
  final int id;
  final String accountName;
  final String accountNumber;
  final Bank? bank;
  final BankBranch? bankBranch;

  BankAccount({
    required this.id,
    required this.accountName,
    required this.accountNumber,
    required this.bank,
    required this.bankBranch,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      id: json["_id"],
      accountName: json["account_holder_name"],
      accountNumber: json["account_number"],
      bank: json["bank"] != null ? Bank.fromJson(json["bank"]) : null,
      bankBranch: json["bankBranch"] != null
          ? BankBranch.fromJson(json["bankBranch"])
          : null,
    );
  }
}
