import 'package:aramex/feature/dashboard/model/single_shipment_summary_data.dart';

class ShipmentSummary {
  final SingleShipmentSummaryData shipmentCounts;
  final SingleShipmentSummaryData amounts;

  ShipmentSummary({
    required this.amounts,
    required this.shipmentCounts,
  });

  factory ShipmentSummary.fromJson({required Map<String, dynamic> json}) {
    return ShipmentSummary(
      amounts: SingleShipmentSummaryData.fromJson(json: json["amounts"]),
      shipmentCounts:
          SingleShipmentSummaryData.fromJson(json: json['shipment_counts']),
    );
  }
}
