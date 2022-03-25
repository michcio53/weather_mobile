import 'package:remote/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  test(
      'Given date with timezone it returns date time without timezone and parse date',
      () {
    const dateWithTimezone = '2022-03-23T05:31:59.860841+01:00';
    final parsedDate = dateWithTimezone.removeTimeZoneFromString();
    expect(parsedDate.hour, 5);
    expect(parsedDate.minute, 31);
  });

  test('Given date withot timezone it returns parsed date', () {
    const dateWithTimezone = '2022-03-23T05:31:59.860841';
    final parsedDate = dateWithTimezone.removeTimeZoneFromString();
    expect(parsedDate.hour, 5);
    expect(parsedDate.minute, 31);
  });
}
