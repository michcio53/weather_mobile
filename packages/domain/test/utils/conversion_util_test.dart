import 'package:domain/utils/conversion_util.dart';
import 'package:test/test.dart';

void main() {
  test(
    'check if temp is calculated correctly',
    () {
      final calculatedFehrenheit = celciusToFehrenheit(10);
      final calculatedFehrenheit2 = celciusToFehrenheit(-16);
      expect(calculatedFehrenheit, 50.0);
      expect(calculatedFehrenheit2, 3.1999999999999993);
    },
  );

  test(
    'check if distance is calculated correctly',
    () {
      final calculatedKilometers = milesPerHourToKiliometerPerHour(123);
      final calculatedKilometers2 = milesPerHourToKiliometerPerHour(15);
      expect(calculatedKilometers, 197.94931200000002);
      expect(calculatedKilometers2, 24.14016);
    },
  );
}
