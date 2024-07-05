// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:limetrack/enums/waste_type.dart';

class Caddy {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String? siteId;
  bool? ownedByLimetrack;
  String? qrCode;
  String? rfId;
  WasteType? wasteType;
  int? volume;
  int? weight;
  String? locationDescription;
  DateTime? validFromTimestamp;
  String? validFromDateTimeUtc;
  DateTime? validToTimestamp;
  String? validToDateTimeUtc;
  int? revision;

  Caddy({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    this.siteId,
    this.ownedByLimetrack,
    this.qrCode,
    this.rfId,
    this.wasteType,
    this.volume,
    this.weight,
    this.locationDescription,
    this.validFromTimestamp,
    this.validFromDateTimeUtc,
    this.validToTimestamp,
    this.validToDateTimeUtc,
    this.revision,
  });

  Caddy.instance({
    required this.$id,
    this.$permissions,
    this.siteId,
    this.ownedByLimetrack,
    this.qrCode,
    this.rfId,
    this.wasteType,
    this.volume,
    this.weight,
    this.locationDescription,
    this.validFromTimestamp,
    this.validFromDateTimeUtc,
    this.validToTimestamp,
    this.validToDateTimeUtc,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  Caddy copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? siteId,
    bool? ownedByLimetrack,
    String? qrCode,
    String? rfId,
    WasteType? wasteType,
    int? volume,
    int? weight,
    String? locationDescription,
    DateTime? validFromTimestamp,
    String? validFromDateTimeUtc,
    DateTime? validToTimestamp,
    String? validToDateTimeUtc,
    int? revision,
  }) {
    return Caddy(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      siteId: siteId ?? this.siteId,
      ownedByLimetrack: ownedByLimetrack ?? this.ownedByLimetrack,
      qrCode: qrCode ?? this.qrCode,
      rfId: rfId ?? this.rfId,
      wasteType: wasteType ?? this.wasteType,
      volume: volume ?? this.volume,
      weight: weight ?? this.weight,
      locationDescription: locationDescription ?? this.locationDescription,
      validFromTimestamp: validFromTimestamp ?? this.validFromTimestamp,
      validFromDateTimeUtc: validFromDateTimeUtc ?? this.validFromDateTimeUtc,
      validToTimestamp: validToTimestamp ?? this.validToTimestamp,
      validToDateTimeUtc: validToDateTimeUtc ?? this.validToDateTimeUtc,
      revision: revision ?? this.revision,
    );
  }

  factory Caddy.fromMap(Map<String, dynamic> map) {
    return Caddy(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      siteId: map['siteId'] as String?,
      ownedByLimetrack: map['ownedByLimetrack'] as bool?,
      qrCode: map['qrCode'] as String?,
      rfId: map['rfId'] as String?,
      wasteType: map['wasteType'] != null ? WasteType.lookup(map['wasteType']) : null,
      volume: map['volume'] as int?,
      weight: map['weight'] as int?,
      locationDescription: map['locationDescription'] as String?,
      validFromTimestamp:
          map['validFromTimestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['validFromTimestamp'] as int, isUtc: true).toLocal() : null,
      validFromDateTimeUtc: map['validFromDateTimeUtc'] as String?,
      validToTimestamp:
          map['validToTimestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['validToTimestamp'] as int, isUtc: true).toLocal() : null,
      validToDateTimeUtc: map['validToDateTimeUtc'] as String?,
      revision: map['revision'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'siteId': siteId,
      'ownedByLimetrack': ownedByLimetrack,
      'qrCode': qrCode,
      'rfId': rfId,
      'wasteType': wasteType?.appWriteEnum,
      'volume': volume,
      'weight': weight,
      'locationDescription': locationDescription,
      'validFromTimestamp': validFromTimestamp?.millisecondsSinceEpoch,
      'validFromDateTimeUtc': validFromDateTimeUtc,
      'validToTimestamp': validToTimestamp?.millisecondsSinceEpoch,
      'validToDateTimeUtc': validToDateTimeUtc,
      'revision': revision,
    };
  }

  factory Caddy.fromJson(String source) => Caddy.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Caddy(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, siteId: $siteId, ownedByLimetrack: $ownedByLimetrack, qrCode: $qrCode, '
        'rfId: $rfId, wasteType: $wasteType, volume: $volume, weight: $weight, locationDescription: $locationDescription, '
        'validFromTimestamp: $validFromTimestamp, validFromDateTimeUtc: $validFromDateTimeUtc, '
        'validToTimestamp: $validToTimestamp, validToDateTimeUtc: $validToDateTimeUtc, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Caddy &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.siteId == siteId &&
        other.ownedByLimetrack == ownedByLimetrack &&
        other.qrCode == qrCode &&
        other.rfId == rfId &&
        other.wasteType == wasteType &&
        other.volume == volume &&
        other.weight == weight &&
        other.locationDescription == locationDescription &&
        other.validFromTimestamp == validFromTimestamp &&
        other.validFromDateTimeUtc == validFromDateTimeUtc &&
        other.validToTimestamp == validToTimestamp &&
        other.validToDateTimeUtc == validToDateTimeUtc &&
        other.revision == revision;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $databaseId.hashCode ^
        $collectionId.hashCode ^
        $permissions.hashCode ^
        siteId.hashCode ^
        ownedByLimetrack.hashCode ^
        qrCode.hashCode ^
        rfId.hashCode ^
        wasteType.hashCode ^
        volume.hashCode ^
        weight.hashCode ^
        locationDescription.hashCode ^
        validFromTimestamp.hashCode ^
        validFromDateTimeUtc.hashCode ^
        validToTimestamp.hashCode ^
        validToDateTimeUtc.hashCode ^
        revision.hashCode;
  }
}
