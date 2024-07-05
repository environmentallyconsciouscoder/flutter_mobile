// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:limetrack/enums/collection_frequency.dart';

class ProducerExistingContract {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String producerSiteId;
  String? carrierId;
  int? weightLimit;
  int? excessWeightCharge;
  CollectionFrequency? collectionFrequency;
  List<String>? pickupExclusionTimes;
  int? revision;

  ProducerExistingContract({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    required this.producerSiteId,
    this.carrierId,
    this.weightLimit,
    this.excessWeightCharge,
    this.collectionFrequency,
    this.pickupExclusionTimes,
    this.revision,
  });

  ProducerExistingContract.instance({
    required this.$id,
    this.$permissions,
    required this.producerSiteId,
    this.carrierId,
    this.weightLimit,
    this.excessWeightCharge,
    this.collectionFrequency,
    this.pickupExclusionTimes,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  ProducerExistingContract copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? producerSiteId,
    String? carrierId,
    int? weightLimit,
    int? excessWeightCharge,
    CollectionFrequency? collectionFrequency,
    List<String>? pickupExclusionTimes,
    int? revision,
  }) {
    return ProducerExistingContract(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      producerSiteId: producerSiteId ?? this.producerSiteId,
      carrierId: carrierId ?? this.carrierId,
      weightLimit: weightLimit ?? this.weightLimit,
      excessWeightCharge: excessWeightCharge ?? this.excessWeightCharge,
      collectionFrequency: collectionFrequency ?? this.collectionFrequency,
      pickupExclusionTimes: pickupExclusionTimes ?? this.pickupExclusionTimes,
      revision: revision ?? this.revision,
    );
  }

  factory ProducerExistingContract.fromMap(Map<String, dynamic> map) {
    return ProducerExistingContract(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      producerSiteId: map['producerSiteId'] as String,
      carrierId: map['carrierId'] as String?,
      weightLimit: map['weightLimit'] as int?,
      excessWeightCharge: map['excessWeightCharge'] as int?,
      collectionFrequency: map['collectionFrequency'] != null ? CollectionFrequency.lookup(map['collectionFrequency']) : null,
      pickupExclusionTimes: map['pickupExclusionTimes'] != null ? List<String>.from(map['pickupExclusionTimes']) : null,
      revision: map['revision'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'producerSiteId': producerSiteId,
      'carrierId': carrierId,
      'weightLimit': weightLimit,
      'excessWeightCharge': excessWeightCharge,
      'collectionFrequency': collectionFrequency?.appWriteEnum,
      'pickupExclusionTimes': pickupExclusionTimes,
      'revision': revision,
    };
  }

  factory ProducerExistingContract.fromJson(String source) => ProducerExistingContract.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ProducerExistingContract(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, producerSiteId: $producerSiteId, carrierId: $carrierId, weightLimit: $weightLimit, '
        'excessWeightCharge: $excessWeightCharge, collectionFrequency: $collectionFrequency, '
        'pickupExclusionTimes: $pickupExclusionTimes, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProducerExistingContract &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.producerSiteId == producerSiteId &&
        other.carrierId == carrierId &&
        other.weightLimit == weightLimit &&
        other.excessWeightCharge == excessWeightCharge &&
        other.collectionFrequency == collectionFrequency &&
        listEquals(other.pickupExclusionTimes, pickupExclusionTimes) &&
        other.revision == revision;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $databaseId.hashCode ^
        $collectionId.hashCode ^
        $permissions.hashCode ^
        producerSiteId.hashCode ^
        carrierId.hashCode ^
        weightLimit.hashCode ^
        excessWeightCharge.hashCode ^
        collectionFrequency.hashCode ^
        pickupExclusionTimes.hashCode ^
        revision.hashCode;
  }
}
