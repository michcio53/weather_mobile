extension DoubleExtension on double {
  double roundToOneDigitAfterComa() {
    return double.parse((this).toStringAsFixed(1));
  }
}
