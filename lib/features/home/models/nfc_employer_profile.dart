import 'dart:convert';

class NfcEmployerProfile {
  final bool? success;
  final Employer? employer;

  NfcEmployerProfile({this.success, this.employer});

  factory NfcEmployerProfile.fromRawJson(String str) =>
      NfcEmployerProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NfcEmployerProfile.fromJson(Map<String, dynamic> json) =>
      NfcEmployerProfile(
        success: json["success"],
        employer:
            json["employer"] == null
                ? null
                : Employer.fromJson(json["employer"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "employer": employer?.toJson(),
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
  final String? companyLogo;
  final String? body;
  final String? heading;

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
    this.companyLogo,
    this.body,
    this.heading,
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
    companyLogo: json["company_logo"],
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
    "company_logo": companyLogo,
    "body": body,
    "heading": heading,
  };
}
