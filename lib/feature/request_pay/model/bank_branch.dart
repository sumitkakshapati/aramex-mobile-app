import 'package:aramex/feature/request_pay/model/bank.dart';

class BankBranch {
  final int id;
  final String location;
  final Bank? bank;

  BankBranch({
    required this.id,
    required this.location,
    this.bank,
  });

  factory BankBranch.fromJson(Map<String, dynamic> json) {
    return BankBranch(
      id: json["_id"],
      location: json["location"] ?? "",
      bank: json["bank"] != null ? Bank.fromJson(json["bank"]) : null,
    );
  }
}
