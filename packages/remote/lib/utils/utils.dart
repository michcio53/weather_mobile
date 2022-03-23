extension StringExtenstion on String {
  DateTime removeTimeZoneFromString() {
    final parsedDate = DateTime.parse(this);
    if (parsedDate.isUtc) {
      final substractedStringDate = substring(0, length - 6);
      return DateTime.parse(substractedStringDate);
    } else {
      return parsedDate;
    }
  }
}
