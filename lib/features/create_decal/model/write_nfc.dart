import 'dart:convert';

// Create a data structure to hold all your information
class NfcTagData {
  final String route;
  final String id;
  final String name;
  final Map<String, dynamic>? extraData;

  NfcTagData({
    required this.route,
    required this.id,
    required this.name,
    this.extraData,
  });

  // Convert to JSON string
  String toJson() => jsonEncode({
    'route': route,
    'id': id,
    'name': name,
    if (extraData != null) 'extra': extraData,
  });

  // Create from JSON string
  factory NfcTagData.fromJson(String jsonStr) {
    final data = jsonDecode(jsonStr);
    print("data::::::::of:::::::::::::::::::::::::::::::::::: $data");
    return NfcTagData(
      route: data['route'],
      id: data['id'],
      name: data['name'],
      extraData: data['extra'] ?? {},
    );
  }
}
