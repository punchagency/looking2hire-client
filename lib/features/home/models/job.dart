// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Job {
  String company;
  String desc;
  Job({required this.company, required this.desc});

  Job copyWith({String? company, String? desc}) {
    return Job(company: company ?? this.company, desc: desc ?? this.desc);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'company': company, 'desc': desc};
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(company: map['company'] as String, desc: map['desc'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) =>
      Job.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Job(company: $company, desc: $desc)';

  @override
  bool operator ==(covariant Job other) {
    if (identical(this, other)) return true;

    return other.company == company && other.desc == desc;
  }

  @override
  int get hashCode => company.hashCode ^ desc.hashCode;
}
