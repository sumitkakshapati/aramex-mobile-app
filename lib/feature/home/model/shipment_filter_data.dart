import 'package:equatable/equatable.dart';

class ShipmentFilterData extends Equatable {
  final String? originCity;
  final String? destinationCity;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? fromKG;
  final double? toKG;
  final double? fromRs;
  final double? toRs;
  final String? status;
  final String? shipmentId;

  const ShipmentFilterData({
    this.originCity,
    this.destinationCity,
    this.endDate,
    this.fromKG,
    this.fromRs,
    this.startDate,
    this.toKG,
    this.toRs,
    this.status,
    this.shipmentId,
  });

  factory ShipmentFilterData.initial() {
    return const ShipmentFilterData();
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
    String? status,
    String? shipmentId,
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
      status: status ?? this.status,
      shipmentId: shipmentId ?? this.shipmentId,
    );
  }

  @override
  List<Object?> get props => [
        originCity,
        destinationCity,
        startDate,
        endDate,
        fromKG,
        toKG,
        fromRs,
        toRs,
        status,
        shipmentId
      ];
}
