class SingleShipmentModeData {
  int noOfShipment;
  double codValue;

  SingleShipmentModeData({
    required this.codValue,
    required this.noOfShipment,
  });

  factory SingleShipmentModeData.fromJson({required Map<String, dynamic> json}) {
    return SingleShipmentModeData(
      codValue: double.tryParse(json["cod_value"]?.toString() ?? "") ?? 0,
      noOfShipment:
          double.tryParse(json["no_of_shipment"]?.toString() ?? "")?.toInt() ??
              0,
    );
  }
}
