class ShipmentFilterData {
  String? originCity;
  String? destinationCity;
  DateTime? startDate;
  DateTime? endDate;
  double? fromKG;
  double? toKG;
  double? fromRs;
  double? toRs;

  ShipmentFilterData({
    this.originCity,
    this.destinationCity,
    this.endDate,
    this.fromKG,
    this.fromRs,
    this.startDate,
    this.toKG,
    this.toRs,
  });

  factory ShipmentFilterData.initial() {
    return ShipmentFilterData();
  }

  ShipmentFilterData copyWith({
    String? originCity,
    String? destinationCity,
    DateTime? startDate,
    DateTime? endDate,
    double? fromKG,
    double? toKG,
    double? fromRs,
    double? toRs,
  }) {
    return ShipmentFilterData(
      originCity: originCity ?? this.originCity,
      destinationCity: destinationCity ?? this.destinationCity,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      fromKG: fromKG ?? this.fromKG,
      toKG: toKG ?? this.toKG,
      fromRs: fromRs ?? this.fromRs,
      toRs: toRs ?? this.toRs,
    );
  }
}
