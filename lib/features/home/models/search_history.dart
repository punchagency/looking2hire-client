// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SearchHistory {
  String id;
  String applicantId;
  String query;
  String createdAt;
  String updatedAt;
  SearchHistory({
    required this.id,
    required this.applicantId,
    required this.query,
    required this.createdAt,
    required this.updatedAt,
  });

  SearchHistory copyWith({
    String? id,
    String? applicantId,
    String? query,
    String? createdAt,
    String? updatedAt,
  }) {
    return SearchHistory(
      id: id ?? this.id,
      applicantId: applicantId ?? this.applicantId,
      query: query ?? this.query,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'applicantId': applicantId,
      'query': query,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory SearchHistory.fromMap(Map<String, dynamic> map) {
    return SearchHistory(
      id: map['_id'] as String,
      applicantId: map['applicantId'] as String,
      query: map['query'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchHistory.fromJson(String source) =>
      SearchHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SearchHistory(id: $id, applicantId: $applicantId, query: $query, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant SearchHistory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.applicantId == applicantId &&
        other.query == query &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        applicantId.hashCode ^
        query.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
