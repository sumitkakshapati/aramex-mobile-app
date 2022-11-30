import 'package:aramex/feature/dashboard/model/single_shipment_summary_data.dart';

class CustomerDetails {
  final String consigneeNumber;
  final SingleShipmentSummaryData shipmentCount;
  final SingleShipmentSummaryData shipmentAmount;

  CustomerDetails({
    required this.consigneeNumber,
    required this.shipmentCount,
    required this.shipmentAmount,
  });

  factory CustomerDetails.fromJson({required Map<String, dynamic> json}) {
    return CustomerDetails(
      consigneeNumber: json["consignee_tel"],
      shipmentCount: SingleShipmentSummaryData.fromJson(
          json: json["shipment_summary"]["shipment_counts"]),
      shipmentAmount: SingleShipmentSummaryData.fromJson(
        json: json["shipment_summary"]["amounts"],
      ),
    );
  }
}
