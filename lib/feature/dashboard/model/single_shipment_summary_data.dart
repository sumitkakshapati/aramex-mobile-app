class SingleShipmentSummaryData {
  double total;
  double inTransit;
  double returned;
  double delivered;

  SingleShipmentSummaryData({
    required this.total,
    required this.inTransit,
    required this.returned,
    required this.delivered,
  });

  factory SingleShipmentSummaryData.fromJson(
      {required Map<String, dynamic> json}) {
    return SingleShipmentSummaryData(
      total: double.tryParse(json['total']?.toString() ?? "0") ?? 0,
      inTransit: double.tryParse(json['in_transit']?.toString() ?? "0") ?? 0,
      returned: double.tryParse(json['returned']?.toString() ?? "0") ?? 0,
      delivered: double.tryParse(json['delivered']?.toString() ?? "0") ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['in_transit'] = inTransit;
    data['returned'] = returned;
    data['delivered'] = delivered;
    return data;
  }
}
