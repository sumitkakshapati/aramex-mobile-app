class ReturnedReason {
  final String reason;
  final int count;
  final double percentage;

  ReturnedReason({
    required this.reason,
    required this.count,
    required this.percentage,
  });

  factory ReturnedReason.fromJson(Map<String, dynamic> json) {
    return ReturnedReason(
      reason: json["return_reason"],
      count: double.parse(json["count"].toString()).toInt(),
      percentage: double.parse(json["percent"].toString()),
    );
  }
}
