import 'dart:convert';

class LoginResponse {
  final bool? success;
  final Employer? employer;
  final String? accessToken;
  final String? refreshToken;

  LoginResponse({
    this.success,
    this.employer,
    this.accessToken,
    this.refreshToken,
  });
  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    employer:
        json["employer"] == null ? null : Employer.fromJson(json["employer"]),
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "employer": employer?.toJson(),
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}

class Employer {
  final String? id;
  final String? companyName;
  final String? address;
  final List<double>? location;
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

  factory Employer.fromRawJson(String str) =>
      Employer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
    id: json["_id"],
    companyName: json["company_name"],
    address: json["address"],
    location:
        json["location"] == null
            ? []
            : List<double>.from(json["location"]!.map((x) => x.toDouble())),
    fullName: json["full_name"],
    email: json["email"],
    phone: json["phone"],
    isVerified: json["isVerified"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
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
  };
}
