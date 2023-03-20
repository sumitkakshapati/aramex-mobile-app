import 'package:aramex/feature/customer/model/return_reason.dart';

class CustomerReturnedDetails {
  final String consigneeNumber;
  final int totalShipment;
  final List<ReturnedReason> reasons;

  CustomerReturnedDetails({
    required this.consigneeNumber,
    required this.totalShipment,
    required this.reasons,
  });

  factory CustomerReturnedDetails.fromJson(Map<String, dynamic> json) {
    return CustomerReturnedDetails(
      consigneeNumber: json["consignee_tel"] ?? "",
      totalShipment: json["total_shipments"],
      reasons: List.from(json["returned_reasons"] ?? [])
          .map((e) => ReturnedReason.fromJson(e))
          .toList(),
    );
  }
}
