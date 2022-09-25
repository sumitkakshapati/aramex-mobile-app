import 'package:aramex/common/constant/env.dart';
import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/splash/resource/startup_api_provider.dart';

class StartUpRepository {
  ApiProvider apiProvider;
  late StartUpApiProvider startupApiProvider;
  UserRepository userRepository;
  Env env;

  StartUpRepository({
    required this.env,
    required this.userRepository,
    required this.apiProvider,
  }) {
    startupApiProvider = StartUpApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      userRepository: userRepository,
    );
  }

  Future<DataResponse<bool>> fetchConfig() async {
    return DataResponse.success(true);
  }
}
