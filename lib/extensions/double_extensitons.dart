extension DoubleExtensions on double {
  double get milesToMeters {
    return this * 1609.34;
  }

  double get metersToMiles {
    return this / 1609.34;
  }
}
