// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String id;
  String name;
  String imageUrl;
  double lat;
  double lng;
  int? miles;
  User({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.lat,
    required this.lng,
    this.miles,
  });

  User copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? lat,
    double? lng,
    int? miles,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      miles: miles ?? this.miles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'lat': lat,
      'lng': lng,
      'miles': miles,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      miles: map['miles'] != null ? map['miles'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, imageUrl: $imageUrl, lat: $lat, lng: $lng, miles: $miles)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.lat == lat &&
        other.lng == lng &&
        other.miles == miles;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        miles.hashCode;
  }
}
