import 'dart:convert';

class ApplicantProfile {
  final bool? success;
  final User? user;

  ApplicantProfile({
    this.success,
    this.user,
  });

  factory ApplicantProfile.fromRawJson(String str) => ApplicantProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApplicantProfile.fromJson(Map<String, dynamic> json) => ApplicantProfile(
    success: json["success"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "user": user?.toJson(),
  };
}

class User {
  final String? id;
  final String? googleId;
  final String? name;
  final String? email;
  final String? description;
  final bool? isVerified;
  final List<EmploymentHistory>? employmentHistory;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? linkedinId;
  final String? heading;
  final String? profilePic;

  User({
    this.id,
    this.googleId,
    this.name,
    this.email,
    this.description,
    this.isVerified,
    this.employmentHistory,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.linkedinId,
    this.heading,
    this.profilePic,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    googleId: json["googleId"],
    name: json["name"],
    email: json["email"],
    description: json["description"],
    isVerified: json["isVerified"],
    employmentHistory: json["employment_history"] == null ? [] : List<EmploymentHistory>.from(json["employment_history"]!.map((x) => EmploymentHistory.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    linkedinId: json["linkedinId"],
    heading: json["heading"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "googleId": googleId,
    "name": name,
    "email": email,
    "description": description,
    "isVerified": isVerified,
    "employment_history": employmentHistory == null ? [] : List<dynamic>.from(employmentHistory!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "linkedinId": linkedinId,
    "heading": heading,
    "profile_pic": profilePic,
  };
}

class EmploymentHistory {
  final String? jobTitle;
  final String? companyLogo;
  final String? companyName;
  final String? employmentType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? description;
  final String? id;

  EmploymentHistory({
    this.jobTitle,
    this.companyLogo,
    this.companyName,
    this.employmentType,
    this.startDate,
    this.endDate,
    this.description,
    this.id,
  });

  factory EmploymentHistory.fromRawJson(String str) => EmploymentHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmploymentHistory.fromJson(Map<String, dynamic> json) => EmploymentHistory(
    jobTitle: json["job_title"],
    companyLogo: json["company_logo"],
    companyName: json["company_name"],
    employmentType: json["employment_type"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    description: json["description"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "job_title": jobTitle,
    "company_logo": companyLogo,
    "company_name": companyName,
    "employment_type": employmentType,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "description": description,
    "_id": id,
  };
}
