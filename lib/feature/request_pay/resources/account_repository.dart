import 'package:aramex/common/constant/env.dart';
import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/common/http/custom_exception.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/request_pay/model/bank.dart';
import 'package:aramex/feature/request_pay/model/bank_account.dart';
import 'package:aramex/feature/request_pay/model/bank_branch.dart';
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
      return DataResponse.success(_items);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
