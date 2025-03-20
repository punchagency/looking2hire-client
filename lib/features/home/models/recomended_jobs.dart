import 'dart:convert';

class RecommendedJobs {
  final bool? success;
  final List<RecommendedJob>? recommendedJobs;

  RecommendedJobs({
    this.success,
    this.recommendedJobs,
  });

  factory RecommendedJobs.fromRawJson(String str) => RecommendedJobs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecommendedJobs.fromJson(Map<String, dynamic> json) => RecommendedJobs(
    success: json["success"],
    recommendedJobs: json["recommendedJobs"] == null ? [] : List<RecommendedJob>.from(json["recommendedJobs"]!.map((x) => RecommendedJob.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "recommendedJobs": recommendedJobs == null ? [] : List<dynamic>.from(recommendedJobs!.map((x) => x.toJson())),
  };
}

class RecommendedJob {
  final String? id;
  final String? employerId;
  final String? companyName;
  final String? jobTitle;
  final String? jobAddress;
  final List<double>? location;
  final String? summary;
  final List<String>? keyResponsibilities;
  final List<String>? qualifications;
  final String? closingStatement;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  RecommendedJob({
    this.id,
    this.employerId,
    this.companyName,
    this.jobTitle,
    this.jobAddress,
    this.location,
    this.summary,
    this.keyResponsibilities,
    this.qualifications,
    this.closingStatement,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory RecommendedJob.fromRawJson(String str) => RecommendedJob.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecommendedJob.fromJson(Map<String, dynamic> json) => RecommendedJob(
    id: json["_id"],
    employerId: json["employerId"],
    companyName: json["company_name"],
    jobTitle: json["job_title"],
    jobAddress: json["job_address"],
    location: json["location"] == null ? [] : List<double>.from(json["location"]!.map((x) => x?.toDouble())),
    summary: json["summary"],
    keyResponsibilities: json["key_responsibilities"] == null ? [] : List<String>.from(json["key_responsibilities"]!.map((x) => x)),
    qualifications: json["qualifications"] == null ? [] : List<String>.from(json["qualifications"]!.map((x) => x)),
    closingStatement: json["closing_statement"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "employerId": employerId,
    "company_name": companyName,
    "job_title": jobTitle,
    "job_address": jobAddress,
    "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
    "summary": summary,
    "key_responsibilities": keyResponsibilities == null ? [] : List<dynamic>.from(keyResponsibilities!.map((x) => x)),
    "qualifications": qualifications == null ? [] : List<dynamic>.from(qualifications!.map((x) => x)),
    "closing_statement": closingStatement,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
