// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Employer {
  String id;
  String company_name;
  String address;
  List<double> location;
  String full_name;
  String email;
  String phone;
  bool isVerified;
  String createdAt;
  String updatedAt;
  Employer({
    required this.id,
    required this.company_name,
    required this.address,
    required this.location,
    required this.full_name,
    required this.email,
    required this.phone,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  Employer copyWith({
    String? id,
    String? company_name,
    String? address,
    List<double>? location,
    String? full_name,
    String? email,
    String? phone,
    bool? isVerified,
    String? createdAt,
    String? updatedAt,
  }) {
    return Employer(
      id: id ?? this.id,
      company_name: company_name ?? this.company_name,
      address: address ?? this.address,
      location: location ?? this.location,
      full_name: full_name ?? this.full_name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'company_name': company_name,
      'address': address,
      'location': location,
      'full_name': full_name,
      'email': email,
      'phone': phone,
      'isVerified': isVerified,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Employer.fromMap(Map<String, dynamic> map) {
    return Employer(
      id: map['_id'] as String,
      company_name: map['company_name'] as String,
      address: map['address'] as String,
      location: List<double>.from((map['location'] as List<dynamic>)),
      full_name: map['full_name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      isVerified: map['isVerified'] as bool,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employer.fromJson(String source) =>
      Employer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Employer(id: $id, company_name: $company_name, address: $address, location: $location, full_name: $full_name, email: $email, phone: $phone, isVerified: $isVerified, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Employer other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.company_name == company_name &&
        other.address == address &&
        listEquals(other.location, location) &&
        other.full_name == full_name &&
        other.email == email &&
        other.phone == phone &&
        other.isVerified == isVerified &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        company_name.hashCode ^
        address.hashCode ^
        location.hashCode ^
        full_name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        isVerified.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
