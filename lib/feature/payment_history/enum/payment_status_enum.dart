enum PaymentStatus {
  Pending("pending"),
  Processing("processing"),
  Completed("completed"),
  Rejected("rejected");

  final String value;

  const PaymentStatus(this.value);

  factory PaymentStatus.fromString(String value) {
    if (value == "pending") {
      return PaymentStatus.Pending;
    } else if (value == "processing") {
      return PaymentStatus.Processing;
    } else if (value == "completed") {
      return PaymentStatus.Completed;
    } else {
      return PaymentStatus.Rejected;
    }
  }
}
