// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:limetrack/enums/entity_type.dart';

class Licence {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  EntityType licenseeType;
  String licenseeId;
  String licensingAuthority;
  String licenceType;
  String licenceNumber;
  String? registrationDate;
  String? expiryDate;
  int? revision;

  Licence({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    required this.licenseeType,
    required this.licenseeId,
    required this.licensingAuthority,
    required this.licenceType,
    required this.licenceNumber,
    this.registrationDate,
    this.expiryDate,
    this.revision,
  });

  Licence.instance({
    required this.$id,
    this.$permissions,
    required this.licenseeType,
    required this.licenseeId,
    required this.licensingAuthority,
    required this.licenceType,
    required this.licenceNumber,
    this.registrationDate,
    this.expiryDate,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  Licence copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    EntityType? licenseeType,
    String? licenseeId,
    String? licensingAuthority,
    String? licenceType,
    String? licenceNumber,
    String? registrationDate,
    String? expiryDate,
    int? revision,
  }) {
    return Licence(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      licenseeType: licenseeType ?? this.licenseeType,
      licenseeId: licenseeId ?? this.licenseeId,
      licensingAuthority: licensingAuthority ?? this.licensingAuthority,
      licenceType: licenceType ?? this.licenceType,
      licenceNumber: licenceNumber ?? this.licenceNumber,
      registrationDate: registrationDate ?? this.registrationDate,
      expiryDate: expiryDate ?? this.expiryDate,
      revision: revision ?? this.revision,
    );
  }

  factory Licence.fromMap(Map<String, dynamic> map) {
    return Licence(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      licenseeType: EntityType.values.byName(map['licenseeType']),
      licenseeId: map['licenseeId'] as String,
      licensingAuthority: map['licensingAuthority'] as String,
      licenceType: map['licenceType'] as String,
      licenceNumber: map['licenceNumber'] as String,
      registrationDate: map['registrationDate'] as String?,
      expiryDate: map['expiryDate'] as String?,
      revision: map['revision'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'licenseeType': licenseeType.appWriteEnum,
      'licenseeId': licenseeId,
      'licensingAuthority': licensingAuthority,
      'licenceType': licenceType,
      'licenceNumber': licenceNumber,
      'registrationDate': registrationDate,
      'expiryDate': expiryDate,
      'revision': revision,
    };
  }

  factory Licence.fromJson(String source) => Licence.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Transfer(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, licenseeType: $licenseeType, licenseeId: $licenseeId, '
        'licensingAuthority: $licensingAuthority, licenceType: $licenceType, licenceNumber: $licenceNumber, '
        'registrationDate: $registrationDate, expiryDate: $expiryDate, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Licence &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.licenseeType == licenseeType &&
        other.licenseeId == licenseeId &&
        other.licensingAuthority == licensingAuthority &&
        other.licenceType == licenceType &&
        other.licenceNumber == licenceNumber &&
        other.registrationDate == registrationDate &&
        other.expiryDate == expiryDate &&
        other.revision == revision;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $databaseId.hashCode ^
        $collectionId.hashCode ^
        $permissions.hashCode ^
        licenseeType.hashCode ^
        licenseeId.hashCode ^
        licensingAuthority.hashCode ^
        licenceType.hashCode ^
        licenceNumber.hashCode ^
        registrationDate.hashCode ^
        expiryDate.hashCode ^
        revision.hashCode;
  }
}
