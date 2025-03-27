import 'dart:convert';

class ScanDecal {
  final bool? success;
  final Scan? scan;

  ScanDecal({this.success, this.scan});

  factory ScanDecal.fromRawJson(String str) =>
      ScanDecal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScanDecal.fromJson(Map<String, dynamic> json) => ScanDecal(
    success: json["success"],
    scan: json["scan"] == null ? null : Scan.fromJson(json["scan"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "scan": scan?.toJson()};
}

class Scan {
  final String? applicantId;
  final String? decalId;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Scan({
    this.applicantId,
    this.decalId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Scan.fromRawJson(String str) => Scan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Scan.fromJson(Map<String, dynamic> json) => Scan(
    applicantId: json["applicantId"],
    decalId: json["decalId"],
    id: json["_id"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "applicantId": applicantId,
    "decalId": decalId,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
