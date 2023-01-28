class PaymentRequestInfo {
  final num currentWeekRequestCount;
  final num availableCOD;
  final num unrequestCOD;

  PaymentRequestInfo({
    required this.currentWeekRequestCount,
    required this.availableCOD,
    required this.unrequestCOD,
  });

  factory PaymentRequestInfo.fromJson(Map<String, dynamic> json) {
    return PaymentRequestInfo(
      currentWeekRequestCount: json["current_week_request_count"] ?? 0,
      availableCOD: json["available_cod"] ?? 0,
      unrequestCOD: json["unrequested_cod"] ?? 0,
    );
  }
}