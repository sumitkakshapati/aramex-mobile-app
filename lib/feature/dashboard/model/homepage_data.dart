import 'package:aramex/feature/dashboard/model/shipment_mode_data.dart';
import 'package:aramex/feature/dashboard/model/shipment_summary.dart';

class HomepageData {
  ShipmentModeData shipmentMode;
  double codCollected;
  double codPaid;
  double balanceAvailable;
  DateTime? balanceNextCycle;
  ShipmentSummary shipmentSummary;
  HomepageData({
    required this.shipmentMode,
    required this.codCollected,
    required this.codPaid,
    required this.balanceAvailable,
    this.balanceNextCycle,
    required this.shipmentSummary,
  });

  factory HomepageData.fromJson({required Map<String, dynamic> json}) {
    return HomepageData(
      shipmentMode: ShipmentModeData.fromJson(json: json["shipment_mode"]),
      codCollected:
          double.tryParse(json["cod"]?["collected"]?.toString() ?? "") ?? 0,
      codPaid: double.tryParse(json["cod"]?["paid"]?.toString() ?? "") ?? 0,
      balanceAvailable: double.tryParse(
              json["balance_info"]?["available"]?.toString() ?? "") ??
          0,
      balanceNextCycle:
          DateTime.tryParse(json["cod"]?["paid"]?.toString() ?? ""),
      shipmentSummary: ShipmentSummary.fromJson(json: json["shipment_summary"]),
    );
  }
}
