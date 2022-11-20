enum ShipmentStatus {
  OnTransit("On Transit"),
  Delivered("Delivered"),
  Returned("Returned");

  final String value;
  const ShipmentStatus(this.value);

  factory ShipmentStatus.fromStatus({required String status}) {
    switch (status.toLowerCase()) {
      case "in-transit":
        return ShipmentStatus.OnTransit;
      case "delivered":
        return ShipmentStatus.Delivered;
      case "returned":
        return ShipmentStatus.Returned;
      default:
        return ShipmentStatus.OnTransit;
    }
  }
}
