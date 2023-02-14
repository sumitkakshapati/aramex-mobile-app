import 'package:aramex/feature/shipping/enum/shipment_status.dart';

class Shipment {
  int id;
  String awbNumber;
  String productGroup;
  String type;
  String services;
  DateTime? pickupDate;
  int pcs;
  double chargingWeight;
  double codValue;
  String shipperNumber;
  String shipperName;
  String originCity;
  String consigneeName;
  String consigneeTel;
  String destinationCity;
  String codLiableBranch;
  DateTime? deliveryStatusDate;
  DateTime? returnStatusDate;
  String? returnReason;
  String shipmentStatus;
  double shippingCharges;
  double insurance;
  double fsc;
  double codFee;
  double totalAmount;
  double vat;
  double grandAmount;
  ShipmentStatus status;
  DateTime? codPaidDate;
  bool codPaid;

  Shipment({
    required this.id,
    required this.awbNumber,
    required this.productGroup,
    required this.type,
    required this.services,
    required this.pickupDate,
    required this.pcs,
    required this.chargingWeight,
    required this.codValue,
    required this.shipperNumber,
    required this.shipperName,
    required this.originCity,
    required this.consigneeName,
    required this.consigneeTel,
    required this.destinationCity,
    required this.codLiableBranch,
    this.deliveryStatusDate,
    this.returnStatusDate,
    this.returnReason,
    required this.shipmentStatus,
    required this.shippingCharges,
    required this.insurance,
    required this.fsc,
    required this.codFee,
    required this.totalAmount,
    required this.vat,
    required this.grandAmount,
    required this.status,
    required this.codPaid,
    this.codPaidDate,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['_id'],
      awbNumber: json['awb_number'],
      productGroup: json['product_group'] ?? "",
      type: json['type'] ?? "",
      services: json['services'] ?? "",
      pickupDate: DateTime.tryParse(json['pickup_date'] ?? ""),
      pcs: json['pcs'] ?? 0,
      chargingWeight:
          double.tryParse(json['charging_weight']?.toString() ?? "") ?? 0,
      codValue: double.tryParse(json['cod_value']?.toString() ?? "") ?? 0,
      shipperNumber: json['shipper_number'] ?? "",
      shipperName: json['shipper_name'] ?? "",
      originCity: json['origin_city'] ?? "",
      consigneeName: json['consignee_name'] ?? '',
      consigneeTel: json['consignee_tel'] ?? "",
      destinationCity: json['destination_city'] ?? "",
      codLiableBranch: json['cod_liable_branch'] ?? "",
      deliveryStatusDate:
          DateTime.tryParse(json['delivery_status_date']?.toString() ?? ""),
      returnStatusDate:
          DateTime.tryParse(json['return_status_date']?.toString() ?? ""),
      returnReason: json['return_reason'],
      shipmentStatus: json['shipment_status'],
      shippingCharges:
          double.tryParse(json['shipping_charges']?.toString() ?? "") ?? 0,
      insurance: double.tryParse(json['insurance']?.toString() ?? "") ?? 0,
      fsc: double.tryParse(json['fsc']?.toString() ?? "") ?? 0,
      codFee: double.tryParse(json['cod_fee']?.toString() ?? "") ?? 0,
      totalAmount: double.tryParse(json['total_amount']?.toString() ?? "") ?? 0,
      vat: double.tryParse(json['vat']?.toString() ?? "") ?? 0,
      grandAmount: double.tryParse(json['grand_amount']?.toString() ?? "") ?? 0,
      status: ShipmentStatus.fromStatus(status: json['shipment_status']),
      codPaid: json["paid_status"] ?? false,
      codPaidDate: DateTime.tryParse(json["cod_paid_date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['awb_number'] = awbNumber;
    data['product_group'] = productGroup;
    data['type'] = type;
    data['services'] = services;
    data['pickup_date'] = pickupDate;
    data['pcs'] = pcs;
    data['charging_weight'] = chargingWeight;
    data['cod_value'] = codValue;
    data['shipper_number'] = shipperNumber;
    data['shipper_name'] = shipperName;
    data['origin_city'] = originCity;
    data['consignee_name'] = consigneeName;
    data['consignee_tel'] = consigneeTel;
    data['destination_city'] = destinationCity;
    data['cod_liable_branch'] = codLiableBranch;
    data['delivery_status_date'] = deliveryStatusDate;
    data['return_status_date'] = returnStatusDate;
    data['return_reason'] = returnReason;
    data['shipment_status'] = shipmentStatus;
    data['shipping_charges'] = shippingCharges;
    data['insurance'] = insurance;
    data['fsc'] = fsc;
    data['cod_fee'] = codFee;
    data['total_amount'] = totalAmount;
    data['vat'] = vat;
    data['grand_amount'] = grandAmount;
    return data;
  }
}
