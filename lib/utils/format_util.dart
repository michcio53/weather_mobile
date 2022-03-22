extension DoubleExtension on double {
  double roundToOneDigitAfterComa() {
    return double.parse(toStringAsFixed(1));
  }
}
