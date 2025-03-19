// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class JobResponse {
  String employerId;
  String job_title;
  String job_address;
  List<double> location;
  String summary;
  List<String> key_responsibilities;
  List<String> qualifications;
  String closing_statement;
  String id;
  String createdAt;
  String updatedAt;
  JobResponse({
    required this.employerId,
    required this.job_title,
    required this.job_address,
    required this.location,
    required this.summary,
    required this.key_responsibilities,
    required this.qualifications,
    required this.closing_statement,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  JobResponse copyWith({
    String? employerId,
    String? job_title,
    String? job_address,
    List<double>? location,
    String? summary,
    List<String>? key_responsibilities,
    List<String>? qualifications,
    String? closing_statement,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    return JobResponse(
      employerId: employerId ?? this.employerId,
      job_title: job_title ?? this.job_title,
      job_address: job_address ?? this.job_address,
      location: location ?? this.location,
      summary: summary ?? this.summary,
      key_responsibilities: key_responsibilities ?? this.key_responsibilities,
      qualifications: qualifications ?? this.qualifications,
      closing_statement: closing_statement ?? this.closing_statement,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employerId': employerId,
      'job_title': job_title,
      'job_address': job_address,
      'location': location,
      'summary': summary,
      'key_responsibilities': key_responsibilities,
      'qualifications': qualifications,
      'closing_statement': closing_statement,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory JobResponse.fromMap(Map<String, dynamic> map) {
    return JobResponse(
      employerId: map['employerId'] as String,
      job_title: map['job_title'] as String,
      job_address: map['job_address'] as String,
      location: List<double>.from((map['location'] as List<dynamic>)),
      summary: map['summary'] as String,
      key_responsibilities: List<String>.from(
        (map['key_responsibilities'] as List<dynamic>),
      ),
      qualifications: List<String>.from(
        (map['qualifications'] as List<dynamic>),
      ),
      closing_statement: map['closing_statement'] as String,
      id: map['_id'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobResponse.fromJson(String source) =>
      JobResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobResponse(employerId: $employerId, job_title: $job_title, job_address: $job_address, location: $location, summary: $summary, key_responsibilities: $key_responsibilities, qualifications: $qualifications, closing_statement: $closing_statement, id: $id, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant JobResponse other) {
    if (identical(this, other)) return true;

    return other.employerId == employerId &&
        other.job_title == job_title &&
        other.job_address == job_address &&
        listEquals(other.location, location) &&
        other.summary == summary &&
        listEquals(other.key_responsibilities, key_responsibilities) &&
        listEquals(other.qualifications, qualifications) &&
        other.closing_statement == closing_statement &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return employerId.hashCode ^
        job_title.hashCode ^
        job_address.hashCode ^
        location.hashCode ^
        summary.hashCode ^
        key_responsibilities.hashCode ^
        qualifications.hashCode ^
        closing_statement.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
