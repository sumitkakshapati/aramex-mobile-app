import 'package:aramex/common/constant/env.dart';
import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/dashboard/model/homepage_data.dart';
import 'package:aramex/feature/dashboard/model/shipment_cities.dart';
import 'package:aramex/feature/dashboard/resources/shipment_api_provider.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:aramex/feature/shipping/model/shipment.dart';
import 'package:dio/dio.dart';

class ShipmentRepository {
  ApiProvider apiProvider;
  late ShipmentApiProvider shipmentApiProvider;
  Env env;
  UserRepository userRepository;

  ShipmentRepository({
    required this.env,
    required this.apiProvider,
    required this.userRepository,
  }) {
    shipmentApiProvider = ShipmentApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      userRepository: userRepository,
    );
  }

  final List<Shipment> _allShipments = [];
  int _totalShipmentCount = -1;

  int get totalShipmentCount => _totalShipmentCount;

  ShipmentCities? _shipmentCities;

  Future<DataResponse<HomepageData>> homepage({
    ShipmentFilterData? shipmentFilterData,
  }) async {
    try {
      final _res = await shipmentApiProvider.homepage(
        shipmentFilterData: shipmentFilterData,
      );
      final _data = HomepageData.fromJson(json: _res["data"]["results"]);
      return DataResponse.success(_data);
    } on DioError catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<Shipment>>> allShipments() async {
    try {
      final _res = await shipmentApiProvider.allShipments();
      final _items = List.from(_res["data"]["results"])
          .map((e) => Shipment.fromJson(e))
          .toList();
      _totalShipmentCount = _res["data"]["total"];
      _allShipments.clear();
      _allShipments.addAll(_items);
      return DataResponse.success(_allShipments);
    } on DioError catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<Shipment>> shipmentByID(int id) async {
    try {
      final _res = await shipmentApiProvider.shipmentsById(id);
      return DataResponse.success(Shipment.fromJson(_res["data"]["results"]));
    } on DioError catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<ShipmentCities>> fetchShipmentCities() async {
    try {
      if (_shipmentCities != null) {
        return DataResponse.success(_shipmentCities);
      }
      final _res = await shipmentApiProvider.fetchAllShipmentsCities();
      final _item = ShipmentCities.fromJson(_res["data"]["results"]);
      _shipmentCities = _item;
      return DataResponse.success(_shipmentCities);
    } on DioError catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
