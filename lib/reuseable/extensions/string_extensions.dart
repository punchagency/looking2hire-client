extension StringExtension on String {
  String get capitalize {
    return this[0].toUpperCase() + substring(1);
  }

  String get firstName {
    if (contains(" ")) {
      return split(" ")[0];
    }
    return this;
  }

  String get lastName {
    if (contains(" ")) {
      return split(" ")[1];
    }
    return this;
  }

  DateTime get toDateTime => DateTime.parse(this);
}
