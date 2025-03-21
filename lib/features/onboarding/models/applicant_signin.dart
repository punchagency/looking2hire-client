import 'dart:convert';

class ApplicantLoginResponse {
  final bool? success;
  final Applicant? applicant;
  final String? accessToken;
  final String? refreshToken;

  ApplicantLoginResponse({
    this.success,
    this.applicant,
    this.accessToken,
    this.refreshToken,
  });

  factory ApplicantLoginResponse.fromRawJson(String str) =>
      ApplicantLoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApplicantLoginResponse.fromJson(Map<String, dynamic> json) =>
      ApplicantLoginResponse(
        success: json["success"],
        applicant:
            json["applicant"] == null
                ? null
                : Applicant.fromJson(json["applicant"]),
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "applicant": applicant?.toJson(),
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}

class Applicant {
  final String? id;
  final String? email;
  final bool? isVerified;
  final List<EmploymentHistory>? employmentHistory;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? description;
  final String? heading;
  final String? name;
  final String? profilePic;

  Applicant({
    this.id,
    this.email,
    this.isVerified,
    this.employmentHistory,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.description,
    this.heading,
    this.name,
    this.profilePic,
  });

  factory Applicant.fromRawJson(String str) =>
      Applicant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Applicant.fromJson(Map<String, dynamic> json) => Applicant(
    id: json["_id"],
    email: json["email"],
    isVerified: json["isVerified"],
    employmentHistory:
        json["employment_history"] == null
            ? []
            : List<EmploymentHistory>.from(
              json["employment_history"]!.map(
                (x) => EmploymentHistory.fromJson(x),
              ),
            ),
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    description: json["description"],
    heading: json["heading"],
    name: json["name"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "isVerified": isVerified,
    "employment_history":
        employmentHistory == null
            ? []
            : List<dynamic>.from(employmentHistory!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "description": description,
    "heading": heading,
    "name": name,
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

  factory EmploymentHistory.fromRawJson(String str) =>
      EmploymentHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmploymentHistory.fromJson(
    Map<String, dynamic> json,
  ) => EmploymentHistory(
    jobTitle: json["job_title"],
    companyLogo: json["company_logo"],
    companyName: json["company_name"],
    employmentType: json["employment_type"],
    startDate:
        json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
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
