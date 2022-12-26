enum PaymentStatus {
  Pending("pending"),
  Processing("processing"),
  Completed("completed"),
  Rejected("rejected"),
  Cancelled("cancelled");

  final String value;

  const PaymentStatus(this.value);

  factory PaymentStatus.fromString(String value) {
    if (value == "pending") {
      return PaymentStatus.Pending;
    } else if (value == "processing") {
      return PaymentStatus.Processing;
    } else if (value == "completed") {
      return PaymentStatus.Completed;
    } else if (value == "cancelled") {
      return PaymentStatus.Cancelled;
    } else {
      return PaymentStatus.Rejected;
    }
  }
}
