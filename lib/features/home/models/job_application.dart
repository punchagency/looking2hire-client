// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class JobApplication {
  String jobId;
  String? applicantId;
  String? status;
  String? id;
  String createdAt;
  String updatedAt;
  JobApplication({
    required this.jobId,
    this.applicantId,
    this.status,
    this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  JobApplication copyWith({
    String? jobId,
    String? applicantId,
    String? status,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    return JobApplication(
      jobId: jobId ?? this.jobId,
      applicantId: applicantId ?? this.applicantId,
      status: status ?? this.status,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobId': jobId,
      'applicantId': applicantId,
      'status': status,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory JobApplication.fromMap(Map<String, dynamic> map) {
    return JobApplication(
      jobId: map['jobId'] as String,
      applicantId:
          map['applicantId'] != null ? map['applicantId'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      id: map['_id'] != null ? map['_id'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobApplication.fromJson(String source) =>
      JobApplication.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobApplication(jobId: $jobId, applicantId: $applicantId, status: $status, id: $id, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant JobApplication other) {
    if (identical(this, other)) return true;

    return other.jobId == jobId &&
        other.applicantId == applicantId &&
        other.status == status &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return jobId.hashCode ^
        applicantId.hashCode ^
        status.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
