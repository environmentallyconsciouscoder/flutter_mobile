// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:limetrack/enums/bin_type.dart';

class Bin {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String? siteId;
  bool? ownedByLimetrack;
  String? qrCode;
  String? rfId;
  BinType? binType;
  int? volume;
  int? weight;
  String? geoLocation;
  String? locationDescription;
  String? accessInfo;
  DateTime? validFromTimestamp;
  String? validFromDateTimeUtc;
  DateTime? validToTimestamp;
  String? validToDateTimeUtc;
  DateTime? lastMaintenanceTimestamp;
  String? lastMaintenanceDateTimeUtc;
  int? revision;

  Bin({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    this.siteId,
    this.ownedByLimetrack,
    this.qrCode,
    this.rfId,
    this.binType,
    this.volume,
    this.weight,
    this.geoLocation,
    this.locationDescription,
    this.accessInfo,
    this.validFromTimestamp,
    this.validFromDateTimeUtc,
    this.validToTimestamp,
    this.validToDateTimeUtc,
    this.lastMaintenanceTimestamp,
    this.lastMaintenanceDateTimeUtc,
    this.revision,
  });

  Bin.instance({
    required this.$id,
    this.$permissions,
    this.siteId,
    this.ownedByLimetrack,
    this.qrCode,
    this.rfId,
    this.binType,
    this.volume,
    this.weight,
    this.geoLocation,
    this.locationDescription,
    this.accessInfo,
    this.validFromTimestamp,
    this.validFromDateTimeUtc,
    this.validToTimestamp,
    this.validToDateTimeUtc,
    this.lastMaintenanceTimestamp,
    this.lastMaintenanceDateTimeUtc,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  Bin copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? siteId,
    bool? ownedByLimetrack,
    String? qrCode,
    String? rfId,
    BinType? binType,
    int? volume,
    int? weight,
    String? geoLocation,
    String? locationDescription,
    String? accessInfo,
    DateTime? validFromTimestamp,
    String? validFromDateTimeUtc,
    DateTime? validToTimestamp,
    String? validToDateTimeUtc,
    DateTime? lastMaintenanceTimestamp,
    String? lastMaintenanceDateTimeUtc,
    int? revision,
  }) {
    return Bin(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      siteId: siteId ?? this.siteId,
      ownedByLimetrack: ownedByLimetrack ?? this.ownedByLimetrack,
      qrCode: qrCode ?? this.qrCode,
      rfId: rfId ?? this.rfId,
      binType: binType ?? this.binType,
      volume: volume ?? this.volume,
      weight: weight ?? this.weight,
      geoLocation: geoLocation ?? this.geoLocation,
      locationDescription: locationDescription ?? this.locationDescription,
      accessInfo: accessInfo ?? this.accessInfo,
      validFromTimestamp: validFromTimestamp ?? this.validFromTimestamp,
      validFromDateTimeUtc: validFromDateTimeUtc ?? this.validFromDateTimeUtc,
      validToTimestamp: validToTimestamp ?? this.validToTimestamp,
      validToDateTimeUtc: validToDateTimeUtc ?? this.validToDateTimeUtc,
      lastMaintenanceTimestamp: lastMaintenanceTimestamp ?? this.lastMaintenanceTimestamp,
      lastMaintenanceDateTimeUtc: lastMaintenanceDateTimeUtc ?? this.lastMaintenanceDateTimeUtc,
      revision: revision ?? this.revision,
    );
  }

  factory Bin.fromMap(Map<String, dynamic> map) {
    return Bin(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      siteId: map['siteId'] as String?,
      ownedByLimetrack: map['ownedByLimetrack'] as bool?,
      qrCode: map['qrCode'] as String?,
      rfId: map['rfId'] as String?,
      binType: map['binType'] != null ? BinType.lookup(map['binType']) : null,
      volume: map['volume'] as int?,
      weight: map['weight'] as int?,
      geoLocation: map['geoLocation'] as String?,
      locationDescription: map['locationDescription'] as String?,
      accessInfo: map['accessInfo'] as String?,
      validFromTimestamp:
          map['validFromTimestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['validFromTimestamp'] as int, isUtc: true).toLocal() : null,
      validFromDateTimeUtc: map['validFromDateTimeUtc'] as String?,
      validToTimestamp:
          map['validToTimestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['validToTimestamp'] as int, isUtc: true).toLocal() : null,
      validToDateTimeUtc: map['validToDateTimeUtc'] as String?,
      lastMaintenanceTimestamp: map['lastMaintenanceTimestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastMaintenanceTimestamp'] as int, isUtc: true).toLocal()
          : null,
      lastMaintenanceDateTimeUtc: map['lastMaintenanceDateTimeUtc'] as String?,
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
      'binType': binType?.appWriteEnum,
      'volume': volume,
      'weight': weight,
      'geoLocation': geoLocation,
      'locationDescription': locationDescription,
      'accessInfo': accessInfo,
      'validFromTimestamp': validFromTimestamp?.millisecondsSinceEpoch,
      'validFromDateTimeUtc': validFromDateTimeUtc,
      'validToTimestamp': validToTimestamp?.millisecondsSinceEpoch,
      'validToDateTimeUtc': validToDateTimeUtc,
      'lastMaintenanceTimestamp': lastMaintenanceTimestamp?.millisecondsSinceEpoch,
      'lastMaintenanceDateTimeUtc': lastMaintenanceDateTimeUtc,
      'revision': revision,
    };
  }

  factory Bin.fromJson(String source) => Bin.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Bin(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, siteId: $siteId, ownedByLimetrack: $ownedByLimetrack, qrCode: $qrCode, '
        'rfId: $rfId, binType: $binType, volume: $volume, weight: $weight, geoLocation: $geoLocation, '
        'locationDescription: $locationDescription, accessInfo: $accessInfo, validFromTimestamp: $validFromTimestamp, '
        'validFromDateTimeUtc: $validFromDateTimeUtc, validToTimestamp: $validToTimestamp, '
        'validToDateTimeUtc: $validToDateTimeUtc, lastMaintenanceTimestamp: $lastMaintenanceTimestamp, '
        'lastMaintenanceDateTimeUtc: $lastMaintenanceDateTimeUtc, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bin &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.siteId == siteId &&
        other.ownedByLimetrack == ownedByLimetrack &&
        other.qrCode == qrCode &&
        other.rfId == rfId &&
        other.binType == binType &&
        other.volume == volume &&
        other.weight == weight &&
        other.geoLocation == geoLocation &&
        other.locationDescription == locationDescription &&
        other.accessInfo == accessInfo &&
        other.validFromTimestamp == validFromTimestamp &&
        other.validFromDateTimeUtc == validFromDateTimeUtc &&
        other.validToTimestamp == validToTimestamp &&
        other.validToDateTimeUtc == validToDateTimeUtc &&
        other.lastMaintenanceTimestamp == lastMaintenanceTimestamp &&
        other.lastMaintenanceDateTimeUtc == lastMaintenanceDateTimeUtc &&
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
        binType.hashCode ^
        volume.hashCode ^
        weight.hashCode ^
        geoLocation.hashCode ^
        locationDescription.hashCode ^
        accessInfo.hashCode ^
        validFromTimestamp.hashCode ^
        validFromDateTimeUtc.hashCode ^
        validToTimestamp.hashCode ^
        validToDateTimeUtc.hashCode ^
        lastMaintenanceTimestamp.hashCode ^
        lastMaintenanceDateTimeUtc.hashCode ^
        revision.hashCode;
  }
}
