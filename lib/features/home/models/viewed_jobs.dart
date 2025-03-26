import 'dart:convert';

class ViewedJobs {
  final bool? success;
  final List<ViewedJob>? viewedJobs;

  ViewedJobs({this.success, this.viewedJobs});

  factory ViewedJobs.fromRawJson(String str) =>
      ViewedJobs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ViewedJobs.fromJson(Map<String, dynamic> json) => ViewedJobs(
    success: json["success"],
    viewedJobs:
        json["viewedJobs"] == null
            ? []
            : List<ViewedJob>.from(
              json["viewedJobs"]!.map((x) => ViewedJob.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "viewedJobs":
        viewedJobs == null
            ? []
            : List<dynamic>.from(viewedJobs!.map((x) => x.toJson())),
  };
}

class ViewedJob {
  final String? id;
  final String? applicantId;
  final JobId? jobId;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? viewedAt;

  ViewedJob({
    this.id,
    this.applicantId,
    this.jobId,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.viewedAt,
  });

  factory ViewedJob.fromRawJson(String str) =>
      ViewedJob.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ViewedJob.fromJson(Map<String, dynamic> json) => ViewedJob(
    id: json["_id"],
    applicantId: json["applicantId"],
    jobId: json["jobId"] == null ? null : JobId.fromJson(json["jobId"]),
    v: json["__v"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    viewedAt:
        json["viewedAt"] == null ? null : DateTime.parse(json["viewedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "applicantId": applicantId,
    "jobId": jobId?.toJson(),
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "viewedAt": viewedAt?.toIso8601String(),
  };
}

class JobId {
  final String? id;
  final String? employerId;
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

  JobId({
    this.id,
    this.employerId,
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

  factory JobId.fromRawJson(String str) => JobId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JobId.fromJson(Map<String, dynamic> json) => JobId(
    id: json["_id"],
    employerId: json["employerId"],
    jobTitle: json["job_title"],
    jobAddress: json["job_address"],
    location:
        json["location"] == null
            ? []
            : List<double>.from(json["location"]!.map((x) => x?.toDouble())),
    summary: json["summary"],
    keyResponsibilities:
        json["key_responsibilities"] == null
            ? []
            : List<String>.from(json["key_responsibilities"]!.map((x) => x)),
    qualifications:
        json["qualifications"] == null
            ? []
            : List<String>.from(json["qualifications"]!.map((x) => x)),
    closingStatement: json["closing_statement"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "employerId": employerId,
    "job_title": jobTitle,
    "job_address": jobAddress,
    "location":
        location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
    "summary": summary,
    "key_responsibilities":
        keyResponsibilities == null
            ? []
            : List<dynamic>.from(keyResponsibilities!.map((x) => x)),
    "qualifications":
        qualifications == null
            ? []
            : List<dynamic>.from(qualifications!.map((x) => x)),
    "closing_statement": closingStatement,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
