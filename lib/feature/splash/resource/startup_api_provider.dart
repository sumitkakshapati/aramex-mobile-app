import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';

class StartUpApiProvider {
  StartUpApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.userRepository,
  });

  final ApiProvider apiProvider;
  final UserRepository userRepository;

  final String baseUrl;

  fetchConfig() async {
    final url = "$baseUrl/config/json";
    return await apiProvider.get(url);
  }
}
