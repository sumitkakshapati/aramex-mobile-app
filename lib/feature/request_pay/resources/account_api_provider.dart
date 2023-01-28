import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/request_pay/enum/payment_request_enum.dart';
import 'package:aramex/feature/request_pay/model/bank_transter_data.dart';
import 'package:aramex/feature/request_pay/model/wallet_transfer_data.dart';

class AccountApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;
  final UserRepository userRepository;

  const AccountApiProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.userRepository,
  });

  Future<dynamic> fetchBank() async {
    final _url = '$baseUrl/bank/feeds';
    return apiProvider.get(_url, token: userRepository.token);
  }

  Future<dynamic> fetchBankBranches(int bankId) async {
    final _url = '$baseUrl/bank-branch/feeds/bank/$bankId';
    return apiProvider.get(_url, token: userRepository.token);
  }

  Future<dynamic> saveBank({
    required int bankId,
    required int branchId,
    required String accountName,
    required String accountNumber,
  }) async {
    final _url = '$baseUrl/bank-account/';
    final _data = {
      "account_number": accountNumber,
      "account_holder_name": accountName,
      "bank_id": bankId,
      "branch_id": branchId,
    };
    return apiProvider.post(
      _url,
      _data,
      token: userRepository.token,
    );
  }

  Future<dynamic> fetchBankAccount() async {
    final _url = '$baseUrl/bank-account/feeds/';
    return apiProvider.get(_url, token: userRepository.token);
  }

  Future<dynamic> fetchUserWallets() async {
    final _url = '$baseUrl/user-wallet';
    return apiProvider.get(_url, token: userRepository.token);
  }

  Future<dynamic> fetchWallets() async {
    final _url = '$baseUrl/wallet/feeds';
    return apiProvider.get(_url, token: userRepository.token);
  }

  Future<dynamic> saveUserWallets(
      {required String username, required int walletId}) async {
    final _url = '$baseUrl/user-wallet';
    final _data = {
      "username": username,
      "wallet_id": walletId,
    };
    return apiProvider.post(
      _url,
      _data,
      token: userRepository.token,
    );
  }

  Future<dynamic> deleteBanksAccount(int bankAccountId) async {
    final _url = '$baseUrl/bank-account/$bankAccountId';
    return apiProvider.delete(_url, token: userRepository.token);
  }

  Future<dynamic> deleteWalletsAccount(int userWalletId) async {
    final _url = '$baseUrl/user-wallet/$userWalletId';
    return apiProvider.delete(_url, token: userRepository.token);
  }

  Future<dynamic> updateUserWallets({
    required int userWalletId,
    required String username,
    required int walletId,
  }) async {
    final _url = '$baseUrl/user-wallet/$userWalletId';
    final _data = {
      "username": username,
      "wallet_id": walletId,
    };
    return apiProvider.put(
      _url,
      _data,
      token: userRepository.token,
    );
  }

  Future<dynamic> updateBankAccount({
    required int bankAccountId,
    required int bankId,
    required int branchId,
    required String accountName,
    required String accountNumber,
  }) async {
    final _url = '$baseUrl/bank-account/$bankAccountId';
    final _data = {
      "account_number": accountNumber,
      "account_holder_name": accountName,
      "bank_id": bankId,
      "branch_id": branchId,
    };
    return apiProvider.put(
      _url,
      _data,
      token: userRepository.token,
    );
  }

  Future<dynamic> requestPayment({
    required double amount,
    required PaymentRequestOption option,
    required bool saveAccount,
    required BankTransferData? bankTransferData,
    required WalletTransferData? walletTransferData,
  }) async {
    final _url = '$baseUrl/payment-request';
    final Map<String, dynamic> _data = {
      "amount": amount,
      "payment_option": option.value,
    };

    if (option == PaymentRequestOption.BankTransfer) {
      _data["bank"] = bankTransferData?.toJson();
      _data["save_account"] = saveAccount;
    }

    if (option == PaymentRequestOption.WalletTransfer) {
      _data["wallet"] = walletTransferData?.toJson();
      _data["save_account"] = saveAccount;
    }

    return apiProvider.post(
      _url,
      _data,
      token: userRepository.token,
    );
  }

  Future<dynamic> fetchAllRequestPayment({int page = 1, String? status}) async {
    final _url = '$baseUrl/payment-request/feeds';
    final Map<String, dynamic> _param = {"page": page};

    if (status != null) {
      _param["status"] = status;
    }

    return apiProvider.get(
      _url,
      queryParams: _param,
      token: userRepository.token,
    );
  }

  Future<dynamic> requestPaymentInfo() async {
    final _url = '$baseUrl/payment-request/info';

    return apiProvider.get(
      _url,
      token: userRepository.token,
    );
  }

  Future<dynamic> cancelPaymentRequest({required int paymentRequestId}) async {
    final _url = '$baseUrl/payment-request/$paymentRequestId/cancel';

    return apiProvider.get(
      _url,
      token: userRepository.token,
    );
  }
}
