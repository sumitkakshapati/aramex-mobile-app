import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
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

  Future<dynamic> homepage({
    ShipmentFilterData? shipmentFilterData,
  }) async {
    final Map<String, dynamic> _params = {};

    if (shipmentFilterData?.startDate != null) {
      _params["from"] =
          Jiffy(shipmentFilterData?.startDate).format("yyyy-MM-dd");
    }

    if (shipmentFilterData?.endDate != null) {
      _params["to"] = Jiffy(shipmentFilterData?.endDate).format("yyyy-MM-dd");
    }

    if (shipmentFilterData?.originCity != null) {
      _params["origin_city"] = shipmentFilterData?.originCity;
    }

    if (shipmentFilterData?.destinationCity != null) {
      _params["destination_city"] = shipmentFilterData?.destinationCity;
    }

    if (shipmentFilterData?.fromRs != null) {
      _params["min_price"] = shipmentFilterData?.fromRs;
    }

    if (shipmentFilterData?.toRs != null) {
      _params["max_price"] = shipmentFilterData?.toRs;
    }

    if (shipmentFilterData?.fromKG != null) {
      _params["min_weight"] = shipmentFilterData?.fromKG;
    }

    if (shipmentFilterData?.toKG != null) {
      _params["max_weight"] = shipmentFilterData?.fromKG;
    }

    if (shipmentFilterData?.status != null) {
      _params["status"] = shipmentFilterData?.status;
    }

    if (shipmentFilterData?.dateDuration != null) {
      _params["duration"] = shipmentFilterData!.dateDuration.value;
    }

    return await apiProvider.get(
      '$baseUrl/shipments/home/feeds',
      queryParams: _params,
      token: userRepository.token,
    );
  }

  Future<dynamic> allShipments({
    ShipmentFilterData? shipmentFilterData,
    int page = 1,
  }) async {
    final Map<String, dynamic> _params = {};

    if (shipmentFilterData?.startDate != null) {
      _params["from"] =
          Jiffy(shipmentFilterData?.startDate).format("yyyy-MM-dd");
    }

    if (shipmentFilterData?.endDate != null) {
      _params["to"] = Jiffy(shipmentFilterData?.endDate).format("yyyy-MM-dd");
    }

    if (shipmentFilterData?.originCity != null) {
      _params["origin_city"] = shipmentFilterData?.originCity;
    }

    if (shipmentFilterData?.destinationCity != null) {
      _params["destination_city"] = shipmentFilterData?.destinationCity;
    }

    if (shipmentFilterData?.fromRs != null) {
      _params["min_price"] = shipmentFilterData?.fromRs;
    }

    if (shipmentFilterData?.toRs != null) {
      _params["max_price"] = shipmentFilterData?.toRs;
    }

    if (shipmentFilterData?.fromKG != null) {
      _params["min_weight"] = shipmentFilterData?.fromKG;
    }

    if (shipmentFilterData?.toKG != null) {
      _params["max_weight"] = shipmentFilterData?.fromKG;
    }

    if (shipmentFilterData?.status != null) {
      _params["status"] = shipmentFilterData?.status;
    }

    if (shipmentFilterData?.shipmentId != null) {
      _params["shipment_id"] = shipmentFilterData?.shipmentId;
    }

    _params["page"] = page;

    return await apiProvider.get(
      '$baseUrl/shipments/feeds',
      queryParams: _params,
      token: userRepository.token,
    );
  }

  Future<dynamic> shipmentsById(int id) async {
    return await apiProvider.get(
      '$baseUrl/shipments/feeds/$id',
      token: userRepository.token,
    );
  }

  Future<dynamic> fetchAllShipmentsCities() async {
    return await apiProvider.get(
      '$baseUrl/shipments/all-cities/',
      token: userRepository.token,
    );
  }

  Future<dynamic> fetchCustomerDetails({
    required String phoneNumber,
    ShipmentFilterData? shipmentFilterData,
  }) async {
    final _body = {
      "mobile_number": phoneNumber,
    };

    final Map<String, dynamic> _params = {};

    if (shipmentFilterData?.startDate != null) {
      _params["from"] =
          Jiffy(shipmentFilterData?.startDate).format("yyyy-MM-dd");
    }

    if (shipmentFilterData?.endDate != null) {
      _params["to"] = Jiffy(shipmentFilterData?.endDate).format("yyyy-MM-dd");
    }

    if (shipmentFilterData?.originCity != null) {
      _params["origin_city"] = shipmentFilterData?.originCity;
    }

    if (shipmentFilterData?.destinationCity != null) {
      _params["destination_city"] = shipmentFilterData?.destinationCity;
    }

    if (shipmentFilterData?.fromRs != null) {
      _params["min_price"] = shipmentFilterData?.fromRs;
    }

    if (shipmentFilterData?.toRs != null) {
      _params["max_price"] = shipmentFilterData?.toRs;
    }

    if (shipmentFilterData?.fromKG != null) {
      _params["min_weight"] = shipmentFilterData?.fromKG;
    }

    if (shipmentFilterData?.toKG != null) {
      _params["max_weight"] = shipmentFilterData?.fromKG;
    }

    if (shipmentFilterData?.dateDuration != null) {
      _params["duration"] = shipmentFilterData?.dateDuration.value;
    }

    final _url = "$baseUrl/customer-details/";

    return await apiProvider.post(
      _url.toString(),
      _body,
      queryParam: _params,
      token: userRepository.token,
    );
  }

  Future<dynamic> fetchCustomerReturnedDetails({
    required String phoneNumber,
    ShipmentFilterData? shipmentFilterData,
  }) async {
    final _body = {
      "mobile_number": phoneNumber,
    };

    final Map<String, dynamic> _params = {};

    if (shipmentFilterData?.startDate != null) {
      _params["from"] =
          Jiffy(shipmentFilterData?.startDate).format("yyyy-MM-dd");
    }

    if (shipmentFilterData?.endDate != null) {
      _params["to"] = Jiffy(shipmentFilterData?.endDate).format("yyyy-MM-dd");
    }

    if (shipmentFilterData?.originCity != null) {
      _params["origin_city"] = shipmentFilterData?.originCity;
    }

    if (shipmentFilterData?.destinationCity != null) {
      _params["destination_city"] = shipmentFilterData?.destinationCity;
    }

    if (shipmentFilterData?.fromRs != null) {
      _params["min_price"] = shipmentFilterData?.fromRs;
    }

    if (shipmentFilterData?.toRs != null) {
      _params["max_price"] = shipmentFilterData?.toRs;
    }

    if (shipmentFilterData?.fromKG != null) {
      _params["min_weight"] = shipmentFilterData?.fromKG;
    }

    if (shipmentFilterData?.toKG != null) {
      _params["max_weight"] = shipmentFilterData?.fromKG;
    }

    if (shipmentFilterData?.dateDuration != null) {
      _params["duration"] = shipmentFilterData?.dateDuration.value;
    }

    final _url = "$baseUrl/customer-details/return";

    return await apiProvider.post(
      _url.toString(),
      _body,
      queryParam: _params,
      token: userRepository.token,
    );
  }
}
