import 'dart:convert';

class LoginResponse {
  final bool? success;
  final Employer? employer;
  final String? accessToken;

  LoginResponse({
    this.success,
    this.employer,
    this.accessToken,
  });

  factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    employer: json["employer"] == null ? null : Employer.fromJson(json["employer"]),
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "employer": employer?.toJson(),
    "accessToken": accessToken,
  };
}

class Employer {
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

  Employer({
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
  });

  factory Employer.fromRawJson(String str) => Employer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
    id: json["_id"],
    companyName: json["company_name"],
    address: json["address"],
    location: json["location"] == null ? [] : List<int>.from(json["location"]!.map((x) => x)),
    fullName: json["full_name"],
    email: json["email"],
    phone: json["phone"],
    isVerified: json["isVerified"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "company_name": companyName,
    "address": address,
    "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
    "full_name": fullName,
    "email": email,
    "phone": phone,
    "isVerified": isVerified,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
