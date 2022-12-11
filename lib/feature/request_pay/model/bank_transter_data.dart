import 'package:aramex/feature/request_pay/model/bank_account.dart';

class BankTransferData {
  final int? bankId;
  final int? branchId;
  final String accountHolderName;
  final String accountNumber;

  BankTransferData({
    required this.bankId,
    required this.branchId,
    required this.accountHolderName,
    required this.accountNumber,
  });

  factory BankTransferData.fromBankAccount(BankAccount bankAccount) {
    return BankTransferData(
      bankId: bankAccount.bank?.id,
      branchId: bankAccount.bankBranch?.id,
      accountHolderName: bankAccount.accountName,
      accountNumber: bankAccount.accountNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "account_number": accountNumber,
      "account_holder_name": accountHolderName,
      "bank_id": bankId,
      "branch_id": branchId,
    };
  }
}
