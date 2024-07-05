// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:limetrack/enums/entity_type.dart';
import 'package:limetrack/models/shared/waste_source.dart';

class Transfer {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String? defraId;
  String? userId;
  EntityType? fromType;
  String? fromId;
  EntityType? toType;
  String? toId;
  String? carrierVehicleId;
  String? carrierVehicleDriver;
  String wasteCode;
  String? subCategory;
  int? weight;
  int? volume;
  String? geoLocation;
  DateTime timestamp;
  String? dateTimeUtc;
  String? nextTransferId;
  bool? inferred;
  WasteSource? wasteSource;
  int? revision;
  String? hash;

  Transfer({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    this.defraId,
    this.userId,
    this.fromType,
    this.fromId,
    this.toType,
    this.toId,
    this.carrierVehicleId,
    this.carrierVehicleDriver,
    required this.wasteCode,
    this.subCategory,
    this.weight,
    this.volume,
    this.geoLocation,
    required this.timestamp,
    this.dateTimeUtc,
    this.nextTransferId,
    this.inferred,
    this.wasteSource,
    this.revision,
    this.hash,
  });

  Transfer.instance({
    required this.$id,
    this.$permissions,
    this.defraId,
    this.userId,
    this.fromType,
    this.fromId,
    this.toType,
    this.toId,
    this.carrierVehicleId,
    this.carrierVehicleDriver,
    required this.wasteCode,
    this.subCategory,
    this.weight,
    this.volume,
    this.geoLocation,
    required this.timestamp,
    this.dateTimeUtc,
    this.nextTransferId,
    this.inferred,
    this.wasteSource,
    this.revision,
    this.hash,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  Transfer copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? defraId,
    String? userId,
    EntityType? fromType,
    String? fromId,
    EntityType? toType,
    String? toId,
    String? carrierVehicleId,
    String? carrierVehicleDriver,
    String? wasteCode,
    String? subCategory,
    int? weight,
    int? volume,
    String? geoLocation,
    DateTime? timestamp,
    String? dateTimeUtc,
    String? nextTransferId,
    bool? inferred,
    WasteSource? wasteSource,
    int? revision,
    String? hash,
  }) {
    return Transfer(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      defraId: defraId ?? this.defraId,
      userId: userId ?? this.userId,
      fromType: fromType ?? this.fromType,
      fromId: fromId ?? this.fromId,
      toType: toType ?? this.toType,
      toId: toId ?? this.toId,
      carrierVehicleId: carrierVehicleId ?? this.carrierVehicleId,
      carrierVehicleDriver: carrierVehicleDriver ?? this.carrierVehicleDriver,
      wasteCode: wasteCode ?? this.wasteCode,
      subCategory: subCategory ?? this.subCategory,
      weight: weight ?? this.weight,
      volume: volume ?? this.volume,
      geoLocation: geoLocation ?? this.geoLocation,
      timestamp: timestamp ?? this.timestamp,
      dateTimeUtc: dateTimeUtc ?? this.dateTimeUtc,
      nextTransferId: nextTransferId ?? this.nextTransferId,
      inferred: inferred ?? this.inferred,
      wasteSource: wasteSource ?? this.wasteSource,
      revision: revision ?? this.revision,
      hash: hash ?? this.hash,
    );
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      defraId: map['defraId'] as String?,
      userId: map['userId'] as String?,
      fromType: map['fromType'] != null ? EntityType.values.byName(map['fromType']) : null,
      fromId: map['fromId'] as String?,
      toType: map['toType'] != null ? EntityType.values.byName(map['toType']) : null,
      toId: map['toId'] as String?,
      carrierVehicleId: map['carrierVehicleId'] as String?,
      carrierVehicleDriver: map['carrierVehicleDriver'] as String?,
      wasteCode: map['wasteCode'] as String,
      subCategory: map['subCategory'] as String?,
      weight: map['weight'] as int?,
      volume: map['volume'] as int?,
      geoLocation: map['geoLocation'] as String?,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int, isUtc: true).toLocal(),
      dateTimeUtc: map['dateTimeUtc'] as String?,
      nextTransferId: map['nextTransferId'] as String?,
      inferred: map['inferred'] as bool?,
      wasteSource: map['wasteSource'] != null ? WasteSource.fromJson(map['wasteSource']) : null,
      revision: map['revision'] as int?,
      hash: map['hash'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'defraId': defraId,
      'userId': userId,
      'fromType': fromType?.appWriteEnum,
      'fromId': fromId,
      'toType': toType?.appWriteEnum,
      'toId': toId,
      'carrierVehicleId': carrierVehicleId,
      'carrierVehicleDriver': carrierVehicleDriver,
      'wasteCode': wasteCode,
      'subCategory': subCategory,
      'weight': weight,
      'volume': volume,
      'geoLocation': geoLocation,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'dateTimeUtc': dateTimeUtc,
      'nextTransferId': nextTransferId,
      'inferred': inferred,
      'wasteSource': wasteSource?.toJson(),
      'revision': revision,
      'hash': hash,
    };
  }

  factory Transfer.fromJson(String source) => Transfer.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Transfer(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, defraId: $defraId, userId: $userId, fromType: $fromType, fromId: $fromId, '
        'toType: $toType, toId: $toId, carrierVehicleId: $carrierVehicleId, carrierVehicleDriver: $carrierVehicleDriver, '
        'wasteCode: $wasteCode, subCategory: $subCategory, weight: $weight, volume: $volume, geoLocation: $geoLocation, '
        'timestamp: $timestamp, dateTimeUtc: $dateTimeUtc, nextTransferId: $nextTransferId, inferred: $inferred, '
        'wasteSource: $wasteSource, revision: $revision, hash: $hash)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transfer &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.defraId == defraId &&
        other.userId == userId &&
        other.fromType == fromType &&
        other.fromId == fromId &&
        other.toType == toType &&
        other.toId == toId &&
        other.carrierVehicleId == carrierVehicleId &&
        other.carrierVehicleDriver == carrierVehicleDriver &&
        other.wasteCode == wasteCode &&
        other.subCategory == subCategory &&
        other.weight == weight &&
        other.volume == volume &&
        other.geoLocation == geoLocation &&
        other.timestamp == timestamp &&
        other.dateTimeUtc == dateTimeUtc &&
        other.nextTransferId == nextTransferId &&
        other.inferred == inferred &&
        other.wasteSource == wasteSource &&
        other.revision == revision &&
        other.hash == hash;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $databaseId.hashCode ^
        $collectionId.hashCode ^
        $permissions.hashCode ^
        defraId.hashCode ^
        userId.hashCode ^
        fromType.hashCode ^
        fromId.hashCode ^
        toType.hashCode ^
        toId.hashCode ^
        carrierVehicleId.hashCode ^
        carrierVehicleDriver.hashCode ^
        wasteCode.hashCode ^
        subCategory.hashCode ^
        weight.hashCode ^
        volume.hashCode ^
        geoLocation.hashCode ^
        timestamp.hashCode ^
        dateTimeUtc.hashCode ^
        nextTransferId.hashCode ^
        inferred.hashCode ^
        wasteSource.hashCode ^
        revision.hashCode ^
        hash.hashCode;
  }
}
