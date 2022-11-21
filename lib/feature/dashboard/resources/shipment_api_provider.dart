import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:jiffy/jiffy.dart';

class ShipmentApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;
  final UserRepository userRepository;

  const ShipmentApiProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.userRepository,
  });

  Future<dynamic> homepage({DateTime? startDate, DateTime? endDate}) async {
    Map<String, dynamic> _params = {};

    if (startDate != null) {
      _params["from"] = Jiffy(startDate).format("yyyy-MM-dd");
    }

    if (endDate != null) {
      _params["to"] = Jiffy(endDate).format("yyyy-MM-dd");
    }

    return await apiProvider.get(
      '$baseUrl/shipments/home/feeds',
      queryParams: _params,
      token: userRepository.token,
    );
  }

  Future<dynamic> allShipments() async {
    return await apiProvider.get(
      '$baseUrl/shipments/feeds',
      token: userRepository.token,
    );
  }

  Future<dynamic> shipmentsById(int id) async {
    return await apiProvider.get(
      '$baseUrl/shipments/feeds/$id',
      token: userRepository.token,
    );
  }
}
