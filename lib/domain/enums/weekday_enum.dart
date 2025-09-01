enum Weekday {
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday'),
  sunday('Sunday');

  final String label;
  const Weekday(this.label);

  static String toWeekdayName(int weekday) {
    return Weekday.values[weekday - 1].label;
  }
}
