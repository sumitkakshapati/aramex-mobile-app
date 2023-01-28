import 'package:aramex/common/constant/env.dart';
import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/common/http/custom_exception.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/account_payment/model/user_wallet.dart';
import 'package:aramex/feature/account_payment/model/wallet.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/payment_history/enum/payment_status_enum.dart';
import 'package:aramex/feature/payment_history/model/payment_request.dart';
import 'package:aramex/feature/request_pay/enum/payment_request_enum.dart';
import 'package:aramex/feature/request_pay/model/bank.dart';
import 'package:aramex/feature/request_pay/model/bank_account.dart';
import 'package:aramex/feature/request_pay/model/bank_branch.dart';
import 'package:aramex/feature/request_pay/model/bank_transter_data.dart';
import 'package:aramex/feature/request_pay/model/payment_request_info.dart';
import 'package:aramex/feature/request_pay/model/wallet_transfer_data.dart';
import 'package:aramex/feature/request_pay/resources/account_api_provider.dart';

class AccountRepository {
  ApiProvider apiProvider;
  late AccountApiProvider accountApiProvider;
  Env env;
  UserRepository userRepository;

  AccountRepository({
    required this.env,
    required this.apiProvider,
    required this.userRepository,
  }) {
    accountApiProvider = AccountApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      userRepository: userRepository,
    );
  }

  final List<Bank> _banks = [];

  List<Bank> get banks => _banks;

  final List<BankAccount> _banksAccounts = [];

  List<BankAccount> get banksAccounts => _banksAccounts;

  final List<Wallet> _wallets = [];

  List<Wallet> get wallets => _wallets;

  final List<UserWallet> _userWallets = [];

  List<UserWallet> get userWallets => _userWallets;

  final List<PaymentRequest> _paymentRequests = [];

  List<PaymentRequest> get paymentRequests => _paymentRequests;

  int _paymentRequestPage = 1;

  int _paymentRequestTotalCount = -1;

  String? lastStatus;

  Future<DataResponse<List<Bank>>> fetchBanks() async {
    try {
      final _res = await accountApiProvider.fetchBank();
      final _items = List.from(_res["data"]?["results"] ?? [])
          .map((e) => Bank.fromJson(e))
          .toList();
      _banks.clear();
      _banks.addAll(_items);
      return DataResponse.success(_banks);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<BankBranch>>> fetchBanksBranch(int bankID) async {
    try {
      final _res = await accountApiProvider.fetchBankBranches(bankID);
      final _items = List.from(_res["data"]?["results"] ?? [])
          .map((e) => BankBranch.fromJson(e))
          .toList();
      return DataResponse.success(_items);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<BankAccount>> saveBank({
    required int bankId,
    required int branchId,
    required String accountName,
    required String accountNumber,
  }) async {
    try {
      final _res = await accountApiProvider.saveBank(
        bankId: bankId,
        accountName: accountName,
        accountNumber: accountNumber,
        branchId: branchId,
      );
      final _items = BankAccount.fromJson(_res["data"]?["results"]);
      _banksAccounts.add(_items);
      return DataResponse.success(_items);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<BankAccount>>> fetchBankAccountList() async {
    try {
      final _res = await accountApiProvider.fetchBankAccount();
      final _items = List.from(_res["data"]?["results"] ?? [])
          .map((e) => BankAccount.fromJson(e))
          .toList();
      _banksAccounts.clear();
      _banksAccounts.addAll(_items);
      return DataResponse.success(_banksAccounts);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<UserWallet>>> fetchUserWallets() async {
    try {
      final _res = await accountApiProvider.fetchUserWallets();
      final _items = List.from(_res["data"]?["results"] ?? [])
          .map((e) => UserWallet.fromJson(e))
          .toList();
      _userWallets.clear();
      _userWallets.addAll(_items);
      return DataResponse.success(_items);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<Wallet>>> fetchWallets() async {
    try {
      if (_wallets.isNotEmpty) {
        return DataResponse.success(_wallets);
      }
      final _res = await accountApiProvider.fetchWallets();
      final _items = List.from(_res["data"]?["results"] ?? [])
          .map((e) => Wallet.fromJson(e))
          .toList();
      _wallets.clear();
      _wallets.addAll(_items);
      return DataResponse.success(_wallets);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<UserWallet>> saveWallet(
      {required int walletId, required String username}) async {
    try {
      final _res = await accountApiProvider.saveUserWallets(
        walletId: walletId,
        username: username,
      );
      final _items = UserWallet.fromJson(_res["data"]?["results"]);
      _userWallets.add(_items);
      return DataResponse.success(_items);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> deleteBankAccount(
      {required int bankAccountId}) async {
    try {
      final _ = await accountApiProvider.deleteBanksAccount(bankAccountId);
      _banksAccounts.removeWhere((e) => e.id == bankAccountId);
      return DataResponse.success(true);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> deleteWalletAccount(
      {required int walletAccountId}) async {
    try {
      final _ = await accountApiProvider.deleteWalletsAccount(walletAccountId);
      _userWallets.removeWhere((e) => e.id == walletAccountId);
      return DataResponse.success(true);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<UserWallet>> updateUserWallet({
    required int userWalletId,
    required int walletId,
    required String username,
  }) async {
    try {
      final _res = await accountApiProvider.updateUserWallets(
        userWalletId: userWalletId,
        walletId: walletId,
        username: username,
      );
      final _items = UserWallet.fromJson(_res["data"]?["results"]);
      final _index = _userWallets.indexWhere((e) => e.id == userWalletId);
      if (_index == -1) {
        _userWallets.add(_items);
      } else {
        _userWallets[_index] = _items;
      }
      return DataResponse.success(_items);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<BankAccount>> updateBankAccount({
    required int bankAccountId,
    required int bankId,
    required int branchId,
    required String accountName,
    required String accountNumber,
  }) async {
    try {
      final _res = await accountApiProvider.updateBankAccount(
        bankAccountId: bankAccountId,
        bankId: bankId,
        accountName: accountName,
        accountNumber: accountNumber,
        branchId: branchId,
      );
      final _items = BankAccount.fromJson(_res["data"]?["results"]);
      final _index = _banksAccounts.indexWhere((e) => e.id == bankAccountId);
      if (_index == -1) {
        _banksAccounts.add(_items);
      } else {
        _banksAccounts[_index] = _items;
      }
      return DataResponse.success(_items);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<PaymentRequest>> requestPayment({
    required double amount,
    required PaymentRequestOption option,
    required bool saveAccount,
    required BankTransferData? bankTransferData,
    required WalletTransferData? walletTransferData,
  }) async {
    try {
      final _res = await accountApiProvider.requestPayment(
        amount: amount,
        bankTransferData: bankTransferData,
        option: option,
        walletTransferData: walletTransferData,
        saveAccount: saveAccount,
      );
      final _items = PaymentRequest.fromJson(_res["data"]?["results"]);
      return DataResponse.success(_items);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<PaymentRequest>>> fetchAllRequestPayment(
      {bool isLoadMore = false, String? status}) async {
    try {
      if (_paymentRequestTotalCount == _paymentRequests.length &&
          isLoadMore &&
          status == lastStatus) {
        return DataResponse.success(_paymentRequests);
      }
      if (isLoadMore && status == lastStatus) {
        _paymentRequestPage++;
      } else {
        _paymentRequests.clear();
        _paymentRequestPage = 1;
        _paymentRequestTotalCount = -1;
        lastStatus = status;
      }
      final _res = await accountApiProvider.fetchAllRequestPayment(
        page: _paymentRequestPage,
        status: status,
      );
      final _items = List.from(_res["data"]["results"])
          .map((e) => PaymentRequest.fromJson(e))
          .toList();
      _paymentRequestTotalCount = _res["data"]["total"];
      _paymentRequests.addAll(_items);
      return DataResponse.success(_paymentRequests);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<PaymentRequest>>>
      fetchAllPendingRequestPayment() async {
    try {
      final _res = await accountApiProvider.fetchAllRequestPayment(
        page: _paymentRequestPage,
        status: PaymentStatus.Pending.value,
      );
      final _items = List.from(_res["data"]["results"])
          .map((e) => PaymentRequest.fromJson(e))
          .toList();
      return DataResponse.success(_items);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<PaymentRequestInfo>> requestPaymentInfo() async {
    try {
      final _res = await accountApiProvider.requestPaymentInfo();
      final _info = PaymentRequestInfo.fromJson(_res["data"]["results"]);
      return DataResponse.success(_info);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> cancelPaymentRequest(
      {required int paymentId}) async {
    try {
      final _ = await accountApiProvider.cancelPaymentRequest(
        paymentRequestId: paymentId,
      );
      _paymentRequests.removeWhere((e) => e.id == paymentId);
      return DataResponse.success(true);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
