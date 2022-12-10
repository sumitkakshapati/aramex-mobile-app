import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';

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
}
