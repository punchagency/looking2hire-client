import 'dart:convert';

class RecentJobs {
  final bool? success;
  final List<RecentJob>? recentJobs;

  RecentJobs({
    this.success,
    this.recentJobs,
  });

  factory RecentJobs.fromRawJson(String str) => RecentJobs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecentJobs.fromJson(Map<String, dynamic> json) => RecentJobs(
    success: json["success"],
    recentJobs: json["jobs"] == null ? [] : List<RecentJob>.from(json["jobs"]!.map((x) => RecentJob.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "recent_jobs": recentJobs == null ? [] : List<dynamic>.from(recentJobs!.map((x) => x.toJson())),
  };
}

class RecentJob {
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

  RecentJob({
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

  factory RecentJob.fromRawJson(String str) => RecentJob.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecentJob.fromJson(Map<String, dynamic> json) => RecentJob(
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
