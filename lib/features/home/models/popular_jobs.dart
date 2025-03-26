import 'dart:convert';

class PopularJobs {
  final bool? success;
  final List<Job>? jobs;

  PopularJobs({this.success, this.jobs});

  factory PopularJobs.fromRawJson(String str) =>
      PopularJobs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopularJobs.fromJson(Map<String, dynamic> json) => PopularJobs(
    success: json["success"],
    jobs:
        json["jobs"] == null
            ? []
            : List<Job>.from(json["jobs"]!.map((x) => Job.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "jobs":
        jobs == null ? [] : List<dynamic>.from(jobs!.map((x) => x.toJson())),
  };
}

class Job {
  final PopularityStats? popularityStats;
  final JobDetails? jobDetails;

  Job({this.popularityStats, this.jobDetails});

  factory Job.fromRawJson(String str) => Job.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    popularityStats:
        json["popularityStats"] == null
            ? null
            : PopularityStats.fromJson(json["popularityStats"]),
    jobDetails:
        json["jobDetails"] == null
            ? null
            : JobDetails.fromJson(json["jobDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "popularityStats": popularityStats?.toJson(),
    "jobDetails": jobDetails?.toJson(),
  };
}

class JobDetails {
  final String? id;
  final String? companyName;
  final String? jobTitle;
  final String? jobAddress;
  final List<double>? location;
  final List<String>? qualifications;

  JobDetails({
    this.id,
    this.companyName,
    this.jobTitle,
    this.jobAddress,
    this.location,
    this.qualifications,
  });

  factory JobDetails.fromRawJson(String str) =>
      JobDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JobDetails.fromJson(Map<String, dynamic> json) => JobDetails(
    id: json["_id"],
    companyName: json["company_name"],
    jobTitle: json["job_title"],
    jobAddress: json["job_address"],
    location:
        json["location"] == null
            ? []
            : List<double>.from(json["location"]!.map((x) => x?.toDouble())),
    qualifications:
        json["qualifications"] == null
            ? []
            : List<String>.from(json["qualifications"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "company_name": companyName,
    "job_title": jobTitle,
    "job_address": jobAddress,
    "location":
        location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
    "qualifications":
        qualifications == null
            ? []
            : List<dynamic>.from(qualifications!.map((x) => x)),
  };
}

class PopularityStats {
  final String? id;
  final int? applicationCount;
  final DateTime? lastUpdated;

  PopularityStats({this.id, this.applicationCount, this.lastUpdated});

  factory PopularityStats.fromRawJson(String str) =>
      PopularityStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopularityStats.fromJson(Map<String, dynamic> json) =>
      PopularityStats(
        id: json["_id"],
        applicationCount: json["applicationCount"],
        lastUpdated:
            json["lastUpdated"] == null
                ? null
                : DateTime.parse(json["lastUpdated"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "applicationCount": applicationCount,
    "lastUpdated": lastUpdated?.toIso8601String(),
  };
}
