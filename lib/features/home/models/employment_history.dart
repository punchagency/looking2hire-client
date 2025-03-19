// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmploymentHistory {
  String job_title;
  String company_logo;
  String company_name;
  String employment_type;
  String start_date;
  String end_date;
  String description;
  String id;
  EmploymentHistory({
    required this.job_title,
    required this.company_logo,
    required this.company_name,
    required this.employment_type,
    required this.start_date,
    required this.end_date,
    required this.description,
    required this.id,
  });

  EmploymentHistory copyWith({
    String? job_title,
    String? company_logo,
    String? company_name,
    String? employment_type,
    String? start_date,
    String? end_date,
    String? description,
    String? id,
  }) {
    return EmploymentHistory(
      job_title: job_title ?? this.job_title,
      company_logo: company_logo ?? this.company_logo,
      company_name: company_name ?? this.company_name,
      employment_type: employment_type ?? this.employment_type,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'job_title': job_title,
      'company_logo': company_logo,
      'company_name': company_name,
      'employment_type': employment_type,
      'start_date': start_date,
      'end_date': end_date,
      'description': description,
      '_id': id,
    };
  }

  factory EmploymentHistory.fromMap(Map<String, dynamic> map) {
    return EmploymentHistory(
      job_title: map['job_title'] as String,
      company_logo: map['company_logo'] as String,
      company_name: map['company_name'] as String,
      employment_type: map['employment_type'] as String,
      start_date: map['start_date'] as String,
      end_date: map['end_date'] as String,
      description: map['description'] as String,
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmploymentHistory.fromJson(String source) =>
      EmploymentHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmploymentHistory(job_title: $job_title, company_logo: $company_logo, company_name: $company_name, employment_type: $employment_type, start_date: $start_date, end_date: $end_date, description: $description, id: $id)';
  }

  @override
  bool operator ==(covariant EmploymentHistory other) {
    if (identical(this, other)) return true;

    return other.job_title == job_title &&
        other.company_logo == company_logo &&
        other.company_name == company_name &&
        other.employment_type == employment_type &&
        other.start_date == start_date &&
        other.end_date == end_date &&
        other.description == description &&
        other.id == id;
  }

  @override
  int get hashCode {
    return job_title.hashCode ^
        company_logo.hashCode ^
        company_name.hashCode ^
        employment_type.hashCode ^
        start_date.hashCode ^
        end_date.hashCode ^
        description.hashCode ^
        id.hashCode;
  }
}
