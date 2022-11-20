import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';

class ShipmentApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;
  final UserRepository userRepository;

  const ShipmentApiProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.userRepository,
  });

  Future<dynamic> homepage() async {
    return await apiProvider.get(
      '$baseUrl/shipments/home/feeds',
      token: userRepository.token,
    );
  }

  Future<dynamic> allShipments() async {
    return await apiProvider.get(
      '$baseUrl/shipments/feeds',
      token: userRepository.token,
    );
  }
}
