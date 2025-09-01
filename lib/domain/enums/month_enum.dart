enum Month {
  january('January'),
  february('February'),
  march('March'),
  april('April'),
  may('May'),
  june('June'),
  july('July'),
  august('August'),
  september('September'),
  october('October'),
  november('November'),
  december('December');

  final String label;
  const Month(this.label);

  static String toMonthName(int month) {
    return Month.values[month - 1].label;
  }
}
