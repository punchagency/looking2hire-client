import 'dart:convert';

class NfcEmployerJobs {
  final bool? success;
  final List<Job>? jobs;
  final Pagination? pagination;

  NfcEmployerJobs({
    this.success,
    this.jobs,
    this.pagination,
  });

  factory NfcEmployerJobs.fromRawJson(String str) => NfcEmployerJobs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NfcEmployerJobs.fromJson(Map<String, dynamic> json) => NfcEmployerJobs(
    success: json["success"],
    jobs: json["jobs"] == null ? [] : List<Job>.from(json["jobs"]!.map((x) => Job.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "jobs": jobs == null ? [] : List<dynamic>.from(jobs!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Job {
  final String? id;
  final EmployerId? employerId;
  final String? jobTitle;
  final String? jobAddress;
  final List<double>? location;
  final String? summary;
  final List<String>? keyResponsibilities;
  final List<String>? qualifications;
  final String? closingStatement;
  final int? salaryMin;
  final int? salaryMax;
  final String? salaryCurrency;
  final String? salaryPeriod;
  final String? workType;
  final String? employmentType;
  final String? seniority;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? companyName;

  Job({
    this.id,
    this.employerId,
    this.jobTitle,
    this.jobAddress,
    this.location,
    this.summary,
    this.keyResponsibilities,
    this.qualifications,
    this.closingStatement,
    this.salaryMin,
    this.salaryMax,
    this.salaryCurrency,
    this.salaryPeriod,
    this.workType,
    this.employmentType,
    this.seniority,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.companyName,
  });

  factory Job.fromRawJson(String str) => Job.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json["_id"],
    employerId: employerIdValues.map[json["employerId"]]!,
    jobTitle: json["job_title"],
    jobAddress: json["job_address"],
    location: json["location"] == null ? [] : List<double>.from(json["location"]!.map((x) => x?.toDouble())),
    summary: json["summary"],
    keyResponsibilities: json["key_responsibilities"] == null ? [] : List<String>.from(json["key_responsibilities"]!.map((x) => x)),
    qualifications: json["qualifications"] == null ? [] : List<String>.from(json["qualifications"]!.map((x) => x)),
    closingStatement: json["closing_statement"],
    salaryMin: json["salary_min"],
    salaryMax: json["salary_max"],
    salaryCurrency: json["salary_currency"],
    salaryPeriod: json["salary_period"],
    workType: json["work_type"],
    employmentType: json["employment_type"],
    seniority: json["seniority"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    companyName: json["company_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "employerId": employerIdValues.reverse[employerId],
    "job_title": jobTitle,
    "job_address": jobAddress,
    "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
    "summary": summary,
    "key_responsibilities": keyResponsibilities == null ? [] : List<dynamic>.from(keyResponsibilities!.map((x) => x)),
    "qualifications": qualifications == null ? [] : List<dynamic>.from(qualifications!.map((x) => x)),
    "closing_statement": closingStatement,
    "salary_min": salaryMin,
    "salary_max": salaryMax,
    "salary_currency": salaryCurrency,
    "salary_period": salaryPeriod,
    "work_type": workType,
    "employment_type": employmentType,
    "seniority": seniority,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "company_name": companyName,
  };
}

enum EmployerId {
  THE_67_DACE9763_FA7_BEEA3_D4726_A
}

final employerIdValues = EnumValues({
  "67dace9763fa7beea3d4726a": EmployerId.THE_67_DACE9763_FA7_BEEA3_D4726_A
});

class Pagination {
  final int? total;
  final int? page;
  final int? totalPages;
  final bool? hasNextPage;
  final bool? hasPrevPage;

  Pagination({
    this.total,
    this.page,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

  factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    page: json["page"],
    totalPages: json["totalPages"],
    hasNextPage: json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "totalPages": totalPages,
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
