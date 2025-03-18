// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Applicant {
  String id;
  String googleId;
  String name;
  String email;
  bool isVerified;
  List employment_history;
  String createdAt;
  String updatedAt;
  String linkedinId;
  Applicant({
    required this.id,
    required this.googleId,
    required this.name,
    required this.email,
    required this.isVerified,
    required this.employment_history,
    required this.createdAt,
    required this.updatedAt,
    required this.linkedinId,
  });

  Applicant copyWith({
    String? id,
    String? googleId,
    String? name,
    String? email,
    bool? isVerified,
    List? employment_history,
    String? createdAt,
    String? updatedAt,
    String? linkedinId,
  }) {
    return Applicant(
      id: id ?? this.id,
      googleId: googleId ?? this.googleId,
      name: name ?? this.name,
      email: email ?? this.email,
      isVerified: isVerified ?? this.isVerified,
      employment_history: employment_history ?? this.employment_history,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      linkedinId: linkedinId ?? this.linkedinId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'googleId': googleId,
      'name': name,
      'email': email,
      'isVerified': isVerified,
      'employment_history': employment_history,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'linkedinId': linkedinId,
    };
  }

  factory Applicant.fromMap(Map<String, dynamic> map) {
    return Applicant(
      id: map['_id'] as String,
      googleId: map['googleId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      isVerified: map['isVerified'] as bool,
      employment_history: List.from((map['employment_history'] as List)),
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      linkedinId: map['linkedinId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Applicant.fromJson(String source) =>
      Applicant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Applicant(id: $id, googleId: $googleId, name: $name, email: $email, isVerified: $isVerified, employment_history: $employment_history, createdAt: $createdAt, updatedAt: $updatedAt, linkedinId: $linkedinId)';
  }

  @override
  bool operator ==(covariant Applicant other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.googleId == googleId &&
        other.name == name &&
        other.email == email &&
        other.isVerified == isVerified &&
        listEquals(other.employment_history, employment_history) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.linkedinId == linkedinId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        googleId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        isVerified.hashCode ^
        employment_history.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        linkedinId.hashCode;
  }
}
