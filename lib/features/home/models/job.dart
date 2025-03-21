// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:looking2hire/features/home/models/job_application.dart';

class Job {
  String id;
  String? company_name;
  String job_title;
  String job_address;
  List<double> location;
  String summary;
  List<String> key_responsibilities;
  List<String> qualifications;
  String closing_statement;
  int? salary_min;
  int? salary_max;
  String? salary_currency;
  String? salary_period;
  String? work_type;
  String? employment_type;
  String? seniority;
  String createdAt;
  String updatedAt;
  Employer? employer;
  ApplicationStats? applicationStats;
  List<JobApplication>? applications;
  Job({
    required this.id,
    this.company_name,
    required this.job_title,
    required this.job_address,
    required this.location,
    required this.summary,
    required this.key_responsibilities,
    required this.qualifications,
    required this.closing_statement,
    this.salary_min,
    this.salary_max,
    this.salary_currency,
    this.salary_period,
    this.work_type,
    this.employment_type,
    this.seniority,
    required this.createdAt,
    required this.updatedAt,
    this.employer,
    this.applicationStats,
    this.applications,
  });

  Job copyWith({
    String? id,
    String? company_name,
    String? job_title,
    String? job_address,
    List<double>? location,
    String? summary,
    List<String>? key_responsibilities,
    List<String>? qualifications,
    String? closing_statement,
    int? salary_min,
    int? salary_max,
    String? salary_currency,
    String? salary_period,
    String? work_type,
    String? employment_type,
    String? seniority,
    String? createdAt,
    String? updatedAt,
    Employer? employer,
    ApplicationStats? applicationStats,
    List<JobApplication>? applications,
  }) {
    return Job(
      id: id ?? this.id,
      company_name: company_name ?? this.company_name,
      job_title: job_title ?? this.job_title,
      job_address: job_address ?? this.job_address,
      location: location ?? this.location,
      summary: summary ?? this.summary,
      key_responsibilities: key_responsibilities ?? this.key_responsibilities,
      qualifications: qualifications ?? this.qualifications,
      closing_statement: closing_statement ?? this.closing_statement,
      salary_min: salary_min ?? this.salary_min,
      salary_max: salary_max ?? this.salary_max,
      salary_currency: salary_currency ?? this.salary_currency,
      salary_period: salary_period ?? this.salary_period,
      work_type: work_type ?? this.work_type,
      employment_type: employment_type ?? this.employment_type,
      seniority: seniority ?? this.seniority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      employer: employer ?? this.employer,
      applicationStats: applicationStats ?? this.applicationStats,
      applications: applications ?? this.applications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'company_name': company_name,
      'job_title': job_title,
      'job_address': job_address,
      'location': location,
      'summary': summary,
      'key_responsibilities': key_responsibilities,
      'qualifications': qualifications,
      'closing_statement': closing_statement,
      'salary_min': salary_min,
      'salary_max': salary_max,
      'salary_currency': salary_currency,
      'salary_period': salary_period,
      'work_type': work_type,
      'employment_type': employment_type,
      'seniority': seniority,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'employer': employer?.toMap(),
      'applicationStats': applicationStats?.toMap(),
      'applications': applications?.map((x) => x?.toMap()).toList(),
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      id: map['_id'] as String,
      company_name: map['company_name'] as String?,
      job_title: map['job_title'] as String,
      job_address: map['job_address'] as String,
      location: List<double>.from(
        (map['location'] as List<dynamic>).map((e) => e?.toDouble()),
      ),
      summary: map['summary'] as String,
      key_responsibilities: List<String>.from(
        (map['key_responsibilities'] as List<dynamic>),
      ),
      qualifications: List<String>.from(
        (map['qualifications'] as List<dynamic>),
      ),
      closing_statement: map['closing_statement'] as String,
      salary_min: map['salary_min'] != null ? map['salary_min'] as int : null,
      salary_max: map['salary_max'] != null ? map['salary_max'] as int : null,
      salary_currency:
          map['salary_currency'] != null
              ? map['salary_currency'] as String
              : null,
      salary_period:
          map['salary_period'] != null ? map['salary_period'] as String : null,
      work_type: map['work_type'] != null ? map['work_type'] as String : null,
      employment_type:
          map['employment_type'] != null
              ? map['employment_type'] as String
              : null,
      seniority: map['seniority'] != null ? map['seniority'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      employer:
          map['employer'] != null
              ? Employer.fromMap(map['employer'] as Map<String, dynamic>)
              : null,
      applicationStats:
          map['applicationStats'] != null
              ? ApplicationStats.fromMap(
                map['applicationStats'] as Map<String, dynamic>,
              )
              : null,
      applications:
          map['applications'] != null
              ? List<JobApplication>.from(
                (map['applications'] as List<int>).map<JobApplication?>(
                  (x) => JobApplication.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) =>
      Job.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Job(id: $id, company_name: $company_name, job_title: $job_title, job_address: $job_address, location: $location, summary: $summary, key_responsibilities: $key_responsibilities, qualifications: $qualifications, closing_statement: $closing_statement, salary_min: $salary_min, salary_max: $salary_max, salary_currency: $salary_currency, salary_period: $salary_period, work_type: $work_type, employment_type: $employment_type, seniority: $seniority, createdAt: $createdAt, updatedAt: $updatedAt, employer: $employer, applicationStats: $applicationStats, applications: $applications)';
  }

  @override
  bool operator ==(covariant Job other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.company_name == company_name &&
        other.job_title == job_title &&
        other.job_address == job_address &&
        listEquals(other.location, location) &&
        other.summary == summary &&
        listEquals(other.key_responsibilities, key_responsibilities) &&
        listEquals(other.qualifications, qualifications) &&
        other.closing_statement == closing_statement &&
        other.salary_min == salary_min &&
        other.salary_max == salary_max &&
        other.salary_currency == salary_currency &&
        other.salary_period == salary_period &&
        other.work_type == work_type &&
        other.employment_type == employment_type &&
        other.seniority == seniority &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.employer == employer &&
        other.applicationStats == applicationStats &&
        listEquals(other.applications, applications);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        company_name.hashCode ^
        job_title.hashCode ^
        job_address.hashCode ^
        location.hashCode ^
        summary.hashCode ^
        key_responsibilities.hashCode ^
        qualifications.hashCode ^
        closing_statement.hashCode ^
        salary_min.hashCode ^
        salary_max.hashCode ^
        salary_currency.hashCode ^
        salary_period.hashCode ^
        work_type.hashCode ^
        employment_type.hashCode ^
        seniority.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        employer.hashCode ^
        applicationStats.hashCode ^
        applications.hashCode;
  }
}

class Employer {
  String id;
  String company_name;
  String address;
  String full_name;
  String email;
  String phone;
  String? body;
  String? company_logo;
  String? heading;
  Employer({
    required this.id,
    required this.company_name,
    required this.address,
    required this.full_name,
    required this.email,
    required this.phone,
    this.body,
    this.company_logo,
    this.heading,
  });

  Employer copyWith({
    String? id,
    String? company_name,
    String? address,
    String? full_name,
    String? email,
    String? phone,
    String? body,
    String? company_logo,
    String? heading,
  }) {
    return Employer(
      id: id ?? this.id,
      company_name: company_name ?? this.company_name,
      address: address ?? this.address,
      full_name: full_name ?? this.full_name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      body: body ?? this.body,
      company_logo: company_logo ?? this.company_logo,
      heading: heading ?? this.heading,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'company_name': company_name,
      'address': address,
      'full_name': full_name,
      'email': email,
      'phone': phone,
      'body': body,
      'company_logo': company_logo,
      'heading': heading,
    };
  }

  factory Employer.fromMap(Map<String, dynamic> map) {
    return Employer(
      id: map['_id'] as String,
      company_name: map['company_name'] as String,
      address: map['address'] as String,
      full_name: map['full_name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      body: map['body'] != null ? map['body'] as String : null,
      company_logo:
          map['company_logo'] != null ? map['company_logo'] as String : null,
      heading: map['heading'] != null ? map['heading'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employer.fromJson(String source) =>
      Employer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Employer(id: $id, company_name: $company_name, address: $address, full_name: $full_name, email: $email, phone: $phone, body: $body, company_logo: $company_logo, heading: $heading)';
  }

  @override
  bool operator ==(covariant Employer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.company_name == company_name &&
        other.address == address &&
        other.full_name == full_name &&
        other.email == email &&
        other.phone == phone &&
        other.body == body &&
        other.company_logo == company_logo &&
        other.heading == heading;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        company_name.hashCode ^
        address.hashCode ^
        full_name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        body.hashCode ^
        company_logo.hashCode ^
        heading.hashCode;
  }
}

class ApplicationStats {
  int total;
  int rejected;
  int hired;
  ApplicationStats({
    required this.total,
    required this.rejected,
    required this.hired,
  });

  ApplicationStats copyWith({int? total, int? rejected, int? hired}) {
    return ApplicationStats(
      total: total ?? this.total,
      rejected: rejected ?? this.rejected,
      hired: hired ?? this.hired,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'rejected': rejected,
      'hired': hired,
    };
  }

  factory ApplicationStats.fromMap(Map<String, dynamic> map) {
    return ApplicationStats(
      total: map['total'] as int,
      rejected: map['rejected'] as int,
      hired: map['hired'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplicationStats.fromJson(String source) =>
      ApplicationStats.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ApplicationStats(total: $total, rejected: $rejected, hired: $hired)';

  @override
  bool operator ==(covariant ApplicationStats other) {
    if (identical(this, other)) return true;

    return other.total == total &&
        other.rejected == rejected &&
        other.hired == hired;
  }

  @override
  int get hashCode => total.hashCode ^ rejected.hashCode ^ hired.hashCode;
}
