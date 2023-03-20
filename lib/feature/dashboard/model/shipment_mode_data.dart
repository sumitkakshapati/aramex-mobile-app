import 'package:aramex/feature/dashboard/model/single_shipment_mode_data.dart';

class ShipmentModeData {
  SingleShipmentModeData cod;
  SingleShipmentModeData prepaid;
  SingleShipmentModeData total;

  ShipmentModeData({
    required this.cod,
    required this.prepaid,
    required this.total,
  });

  factory ShipmentModeData.fromJson({required Map<String, dynamic> json}) {
    return ShipmentModeData(
      cod: SingleShipmentModeData.fromJson(json: json["cod"]),
      prepaid: SingleShipmentModeData.fromJson(json: json["prepaid"]),
      total: SingleShipmentModeData.fromJson(json: json["total"]),
    );
  }
}
