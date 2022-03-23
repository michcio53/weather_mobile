import 'package:flutter_test/flutter_test.dart';
import 'package:weather_mobile/utils/format_util.dart';

void main() {
  test('Given double it double with one digit', () async {
    final parsed = fullDouble.roundToOneDigitAfterComa();
    final parsed2 = fullDouble2.roundToOneDigitAfterComa();
    expect(parsed, parsedDouble);
    expect(parsed2, parsedDouble2);
  });

  test('Given DateTime it returns time', () async {
    final stringTime = time.toTimeString();
    final stringTime2 = time2.toTimeString();
    expect(stringTime, '06:32');
    expect(stringTime2, '10:54');
  });
}

final time = DateTime.parse('2022-03-23T02:32:24.690752-04:00');
final time2 = DateTime.parse('2022-03-23T06:54:24.114949-04:00');
const fullDouble = 1.123;
const fullDouble2 = 3.123123123;
const parsedDouble = 1.1;
const parsedDouble2 = 3.1;
