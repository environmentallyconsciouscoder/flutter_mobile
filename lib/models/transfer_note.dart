// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:limetrack/enums/entity_type.dart';

class TransferNote {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String publicRef;
  EntityType fromType;
  String fromId;
  EntityType toType;
  String toId;
  EntityType forType;
  String forId;
  DateTime timestampRangeStart;
  DateTime timestampRangeEnd;
  DateTime? generatedAtTimestamp;
  DateTime? emailedAtTimestamp;
  String? emailedTo;
  int? revision;

  TransferNote({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    required this.publicRef,
    required this.fromType,
    required this.fromId,
    required this.toType,
    required this.toId,
    required this.forType,
    required this.forId,
    required this.timestampRangeStart,
    required this.timestampRangeEnd,
    this.generatedAtTimestamp,
    this.emailedAtTimestamp,
    this.emailedTo,
    this.revision,
  });

  TransferNote.instance({
    required this.$id,
    this.$permissions,
    required this.publicRef,
    required this.fromType,
    required this.fromId,
    required this.toType,
    required this.toId,
    required this.forType,
    required this.forId,
    required this.timestampRangeStart,
    required this.timestampRangeEnd,
    this.generatedAtTimestamp,
    this.emailedAtTimestamp,
    this.emailedTo,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  TransferNote copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? publicRef,
    EntityType? fromType,
    String? fromId,
    EntityType? toType,
    String? toId,
    EntityType? forType,
    String? forId,
    DateTime? timestampRangeStart,
    DateTime? timestampRangeEnd,
    DateTime? generatedAtTimestamp,
    DateTime? emailedAtTimestamp,
    String? emailedTo,
    int? revision,
  }) {
    return TransferNote(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      publicRef: publicRef ?? this.publicRef,
      fromType: fromType ?? this.fromType,
      fromId: fromId ?? this.fromId,
      toType: toType ?? this.toType,
      toId: toId ?? this.toId,
      forType: forType ?? this.forType,
      forId: forId ?? this.forId,
      timestampRangeStart: timestampRangeStart ?? this.timestampRangeStart,
      timestampRangeEnd: timestampRangeEnd ?? this.timestampRangeEnd,
      generatedAtTimestamp: generatedAtTimestamp ?? this.generatedAtTimestamp,
      emailedAtTimestamp: emailedAtTimestamp ?? this.emailedAtTimestamp,
      emailedTo: emailedTo ?? this.emailedTo,
      revision: revision ?? this.revision,
    );
  }

  factory TransferNote.fromMap(Map<String, dynamic> map) {
    return TransferNote(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      publicRef: map['publicRef'] as String,
      fromType: EntityType.values.byName(map['fromType']),
      fromId: map['fromId'] as String,
      toType: EntityType.values.byName(map['toType']),
      toId: map['toId'] as String,
      forType: EntityType.values.byName(map['forType']),
      forId: map['forId'] as String,
      timestampRangeStart: DateTime.fromMillisecondsSinceEpoch(map['timestampRangeStart'] as int, isUtc: true).toLocal(),
      timestampRangeEnd: DateTime.fromMillisecondsSinceEpoch(map['timestampRangeEnd'] as int, isUtc: true).toLocal(),
      generatedAtTimestamp:
          map['generatedAtTimestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['generatedAtTimestamp'] as int, isUtc: true).toLocal() : null,
      emailedAtTimestamp:
          map['emailedAtTimestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['emailedAtTimestamp'] as int, isUtc: true).toLocal() : null,
      emailedTo: map['emailedTo'] as String?,
      revision: map['revision'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'publicRef': publicRef,
      'fromType': fromType.appWriteEnum,
      'fromId': fromId,
      'toType': toType.appWriteEnum,
      'toId': toId,
      'forType': forType.appWriteEnum,
      'forId': forId,
      'timestampRangeStart': timestampRangeStart.millisecondsSinceEpoch,
      'timestampRangeEnd': timestampRangeEnd.millisecondsSinceEpoch,
      'generatedAtTimestamp': generatedAtTimestamp?.millisecondsSinceEpoch,
      'emailedAtTimestamp': emailedAtTimestamp?.millisecondsSinceEpoch,
      'emailedTo': emailedTo,
      'revision': revision,
    };
  }

  factory TransferNote.fromJson(String source) => TransferNote.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TransferNote(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, publicRef: $publicRef, fromType: $fromType, fromId: $fromId, toType: $toType, '
        'toId: $toId, forType: $forType, forId: $forId, timestampRangeStart: $timestampRangeStart, '
        'timestampRangeEnd: $timestampRangeEnd, generatedAtTimestamp: $generatedAtTimestamp, '
        'emailedAtTimestamp: $emailedAtTimestamp, emailedTo: $emailedTo, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransferNote &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.publicRef == publicRef &&
        other.fromType == fromType &&
        other.fromId == fromId &&
        other.toType == toType &&
        other.toId == toId &&
        other.forType == forType &&
        other.forId == forId &&
        other.timestampRangeStart == timestampRangeStart &&
        other.timestampRangeEnd == timestampRangeEnd &&
        other.generatedAtTimestamp == generatedAtTimestamp &&
        other.emailedAtTimestamp == emailedAtTimestamp &&
        other.emailedTo == emailedTo &&
        other.revision == revision;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $databaseId.hashCode ^
        $collectionId.hashCode ^
        $permissions.hashCode ^
        publicRef.hashCode ^
        fromType.hashCode ^
        fromId.hashCode ^
        toType.hashCode ^
        toId.hashCode ^
        forType.hashCode ^
        forId.hashCode ^
        timestampRangeStart.hashCode ^
        timestampRangeEnd.hashCode ^
        generatedAtTimestamp.hashCode ^
        emailedAtTimestamp.hashCode ^
        emailedTo.hashCode ^
        revision.hashCode;
  }
}
