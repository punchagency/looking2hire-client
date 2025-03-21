// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PopularJob {
  String id;
  String jobId;
  int applicationCount;
  String createdAt;
  String lastUpdated;
  String updatedAt;
  PopularJob({
    required this.id,
    required this.jobId,
    required this.applicationCount,
    required this.createdAt,
    required this.lastUpdated,
    required this.updatedAt,
  });

  PopularJob copyWith({
    String? id,
    String? jobId,
    int? applicationCount,
    String? createdAt,
    String? lastUpdated,
    String? updatedAt,
  }) {
    return PopularJob(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      applicationCount: applicationCount ?? this.applicationCount,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'jobId': jobId,
      'applicationCount': applicationCount,
      'createdAt': createdAt,
      'lastUpdated': lastUpdated,
      'updatedAt': updatedAt,
    };
  }

  factory PopularJob.fromMap(Map<String, dynamic> map) {
    return PopularJob(
      id: map['_id'] as String,
      jobId: map['jobId'] as String,
      applicationCount: map['applicationCount'] as int,
      createdAt: map['createdAt'] as String,
      lastUpdated: map['lastUpdated'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PopularJob.fromJson(String source) =>
      PopularJob.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PopularJob(id: $id, jobId: $jobId, applicationCount: $applicationCount, createdAt: $createdAt, lastUpdated: $lastUpdated, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant PopularJob other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.jobId == jobId &&
        other.applicationCount == applicationCount &&
        other.createdAt == createdAt &&
        other.lastUpdated == lastUpdated &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        jobId.hashCode ^
        applicationCount.hashCode ^
        createdAt.hashCode ^
        lastUpdated.hashCode ^
        updatedAt.hashCode;
  }
}
