import 'dart:convert';

class SavedJobs {
  final bool? success;
  final List<SavedJob>? savedJobs;

  SavedJobs({this.success, this.savedJobs});

  factory SavedJobs.fromRawJson(String str) =>
      SavedJobs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SavedJobs.fromJson(Map<String, dynamic> json) => SavedJobs(
    success: json["success"],
    savedJobs:
        json["savedJobs"] == null
            ? []
            : List<SavedJob>.from(
              json["savedJobs"]!.map((x) => SavedJob.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "savedJobs":
        savedJobs == null
            ? []
            : List<dynamic>.from(savedJobs!.map((x) => x.toJson())),
  };
}

class SavedJob {
  final String? id;
  final JobId? jobId;
  final String? applicantId;
  final DateTime? savedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  SavedJob({
    this.id,
    this.jobId,
    this.applicantId,
    this.savedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SavedJob.fromRawJson(String str) =>
      SavedJob.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SavedJob.fromJson(Map<String, dynamic> json) => SavedJob(
    id: json["_id"],
    jobId: json["jobId"] == null ? null : JobId.fromJson(json["jobId"]),
    applicantId: json["applicantId"],
    savedAt: json["savedAt"] == null ? null : DateTime.parse(json["savedAt"]),
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "jobId": jobId?.toJson(),
    "applicantId": applicantId,
    "savedAt": savedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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
