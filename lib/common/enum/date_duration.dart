enum DateDuration {
  ThisWeek("This Week", 'this_week'),
  LastWeek("Last Week", 'last_week'),
  ThisMonth("This Month", 'this_month'),
  LastMonth("Last Month", 'last_month');

  final String title;
  final String value;
  const DateDuration(this.title, this.value);

  static DateDuration? fromString(String value) {
    switch (value.toLowerCase()) {
      case "this week":
        return DateDuration.ThisWeek;
      case "last week":
        return DateDuration.LastWeek;
      case "this month":
        return DateDuration.ThisMonth;
      case "last month":
        return DateDuration.LastMonth;
      default:
        return null;
    }
  }
}
