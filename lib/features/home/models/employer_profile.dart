import 'dart:convert';

class EmployerProfile {
  final bool? success;
  final User? user;

  EmployerProfile({this.success, this.user});

  factory EmployerProfile.fromRawJson(String str) =>
      EmployerProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployerProfile.fromJson(Map<String, dynamic> json) =>
      EmployerProfile(
        success: json["success"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {"success": success, "user": user?.toJson()};
}

class User {
  final String? id;
  final String? companyName;
  final String? address;
  final List<int>? location;
  final String? fullName;
  final String? email;
  final String? phone;
  final bool? isVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? body;
  final String? heading;

  User({
    this.id,
    this.companyName,
    this.address,
    this.location,
    this.fullName,
    this.email,
    this.phone,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.body,
    this.heading,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    companyName: json["company_name"],
    address: json["address"],
    location:
        json["location"] == null
            ? []
            : List<int>.from(json["location"]!.map((x) => x)),
    fullName: json["full_name"],
    email: json["email"],
    phone: json["phone"],
    isVerified: json["isVerified"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    body: json["body"],
    heading: json["heading"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "company_name": companyName,
    "address": address,
    "location":
        location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
    "full_name": fullName,
    "email": email,
    "phone": phone,
    "isVerified": isVerified,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "body": body,
    "heading": heading,
  };
}
