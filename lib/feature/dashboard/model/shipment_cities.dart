class ShipmentCities {
  List<String> originCities;
  List<String> destinationCities;

  ShipmentCities({
    required this.originCities,
    required this.destinationCities,
  });

  factory ShipmentCities.fromJson(Map<String, dynamic> json) {
    return ShipmentCities(
      originCities:
          List.from(json["origin_cities"]).map((e) => e.toString()).toList(),
      destinationCities: List.from(json["destination_cities"])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
