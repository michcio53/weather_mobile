import 'package:intl/intl.dart';

extension DoubleExtension on double {
  double oneDigitAfterComa() {
    return double.parse(toStringAsFixed(1));
  }
}

extension DateTimeExtension on DateTime {
  String toTimeString() {
    final dateFormat = DateFormat("HH:mm");
    return dateFormat.format(this);
  }

  String toDayAndMonth() {
    final dateFormat = DateFormat("dd.MM");
    return dateFormat.format(this);
  }
}
