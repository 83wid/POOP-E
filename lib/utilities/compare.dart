int compare(String? a, String? b) {
  if (a != null && b != null) {
    DateTime date1 = DateTime.parse(a);
    DateTime date2 = DateTime.parse(b);
    if (date1.year != date2.year) return date1.year - date2.year;
    if (date1.month != date2.month) return date1.month - date2.month;
    if (date1.day != date2.day) return date1.day - date2.day;
    if (date1.hour != date2.hour) return date1.hour - date2.hour;
    if (date1.minute != date2.minute) return date1.minute - date2.minute;
  }
  return 0;
}
