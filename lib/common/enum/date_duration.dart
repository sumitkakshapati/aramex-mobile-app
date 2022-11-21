enum DateDuration {
  Week("7 Days"),
  HalfMonth("15 Days"),
  Month("1 Month"),
  Year("365 Days");

  final String value;
  const DateDuration(this.value);

  static DateDuration? fromString(String value) {
    switch (value.toLowerCase()) {
      case "7 days":
        return DateDuration.Week;
      case "15 days":
        return DateDuration.HalfMonth;
      case "1 month":
        return DateDuration.Month;
      case "365 days":
        return DateDuration.Year;
      default:
        return null;
    }
  }
}
