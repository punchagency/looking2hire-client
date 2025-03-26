// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RecentSearch {
  String? id;
  String? applicantId;
  String? query;
  String? createdAt;
  String? updatedAt;
  RecentSearch({
    this.id,
    this.applicantId,
    this.query,
    this.createdAt,
    this.updatedAt,
  });

  RecentSearch copyWith({
    String? id,
    String? applicantId,
    String? query,
    String? createdAt,
    String? updatedAt,
  }) {
    return RecentSearch(
      id: id ?? this.id,
      applicantId: applicantId ?? this.applicantId,
      query: query ?? this.query,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'applicantId': applicantId,
      'query': query,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory RecentSearch.fromMap(Map<String, dynamic> map) {
    return RecentSearch(
      id: map['id'] != null ? map['id'] as String : null,
      applicantId:
          map['applicantId'] != null ? map['applicantId'] as String : null,
      query: map['query'] != null ? map['query'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentSearch.fromJson(String source) =>
      RecentSearch.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RecentSearch(id: $id, applicantId: $applicantId, query: $query, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant RecentSearch other) {
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
