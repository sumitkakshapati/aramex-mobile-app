import 'package:aramex/common/constant/env.dart';
import 'package:aramex/common/http/api_provider.dart';
import 'package:aramex/common/http/custom_exception.dart';
import 'package:aramex/common/http/response.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:aramex/feature/customer/model/customer_details.dart';
import 'package:aramex/feature/customer/model/customer_returned_details.dart';
import 'package:aramex/feature/dashboard/model/homepage_data.dart';
import 'package:aramex/feature/dashboard/model/shipment_cities.dart';
import 'package:aramex/feature/dashboard/resources/shipment_api_provider.dart';
import 'package:aramex/feature/home/model/shipment_filter_data.dart';
import 'package:aramex/feature/shipping/model/shipment.dart';

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
  int _currentShipmentPage = 1;

  int get totalShipmentCount => _totalShipmentCount;

  ShipmentCities? _shipmentCities;

  ShipmentFilterData? _currentShipmentFilterData;

  Future<DataResponse<HomepageData>> homepage({
    ShipmentFilterData? shipmentFilterData,
  }) async {
    try {
      final _res = await shipmentApiProvider.homepage(
        shipmentFilterData: shipmentFilterData,
      );
      final _data = HomepageData.fromJson(json: _res["data"]["results"]);
      return DataResponse.success(_data);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<Shipment>>> allShipments(
      {bool isLoadMore = false, ShipmentFilterData? shipmentFilterData}) async {
    try {
      if (_allShipments.length == _totalShipmentCount &&
          isLoadMore &&
          _currentShipmentFilterData == shipmentFilterData) {
        return DataResponse.success(_allShipments);
      }

      if (isLoadMore && _currentShipmentFilterData == shipmentFilterData) {
        _currentShipmentPage++;
      } else {
        _currentShipmentPage = 1;
        _totalShipmentCount = -1;
        _allShipments.clear();
        _currentShipmentFilterData = shipmentFilterData;
      }

      final _res = await shipmentApiProvider.allShipments(
        page: _currentShipmentPage,
        shipmentFilterData: shipmentFilterData,
      );
      final _items = List.from(_res["data"]["results"])
          .map((e) => Shipment.fromJson(e))
          .toList();
      _totalShipmentCount = _res["data"]["total"];
      _allShipments.addAll(_items);
      return DataResponse.success(_allShipments);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<Shipment>> shipmentByID(int id) async {
    try {
      final _res = await shipmentApiProvider.shipmentsById(id);
      return DataResponse.success(Shipment.fromJson(_res["data"]["results"]));
    } on CustomException catch (e) {
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
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<CustomerDetails>> fetchCustomerDetails({
    required String phoneNumber,
    ShipmentFilterData? shipmentFilterData,
  }) async {
    try {
      final _res = await shipmentApiProvider.fetchCustomerDetails(
        phoneNumber: phoneNumber,
        shipmentFilterData: shipmentFilterData,
      );
      final _item = CustomerDetails.fromJson(json: _res["data"]["results"]);
      return DataResponse.success(_item);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<CustomerReturnedDetails>> fetchCustomerReturnedDetails({
    required String phoneNumber,
    ShipmentFilterData? shipmentFilterData,
  }) async {
    try {
      final _res = await shipmentApiProvider.fetchCustomerReturnedDetails(
        phoneNumber: phoneNumber,
        shipmentFilterData: shipmentFilterData,
      );
      final _item = CustomerReturnedDetails.fromJson(_res["data"]["results"]);
      return DataResponse.success(_item);
    } on CustomException catch (e) {
      return DataResponse.error(e.message);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
