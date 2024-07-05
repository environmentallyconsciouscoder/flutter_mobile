// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class CarrierVehicle {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String carrierId;
  String vehicleRegistration;
  int? revision;

  CarrierVehicle({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    required this.carrierId,
    required this.vehicleRegistration,
    this.revision,
  });

  CarrierVehicle.instance({
    required this.$id,
    this.$permissions,
    required this.carrierId,
    required this.vehicleRegistration,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  CarrierVehicle copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? carrierId,
    String? vehicleRegistration,
    int? revision,
  }) {
    return CarrierVehicle(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      carrierId: carrierId ?? this.carrierId,
      vehicleRegistration: vehicleRegistration ?? this.vehicleRegistration,
      revision: revision ?? this.revision,
    );
  }

  factory CarrierVehicle.fromMap(Map<String, dynamic> map) {
    return CarrierVehicle(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      carrierId: map['carrierId'] as String,
      vehicleRegistration: map['vehicleRegistration'] as String,
      revision: map['revision'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'carrierId': carrierId,
      'vehicleRegistration': vehicleRegistration,
      'revision': revision,
    };
  }

  factory CarrierVehicle.fromJson(String source) => CarrierVehicle.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'CarrierVehicle(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
      '\$permissions: ${$permissions}, carrierId: $carrierId, vehicleRegistration: $vehicleRegistration, revision: $revision)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarrierVehicle &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.carrierId == carrierId &&
        other.vehicleRegistration == vehicleRegistration &&
        other.revision == revision;
  }

  @override
  int get hashCode =>
      $id.hashCode ^
      $databaseId.hashCode ^
      $collectionId.hashCode ^
      $permissions.hashCode ^
      vehicleRegistration.hashCode ^
      carrierId.hashCode ^
      revision.hashCode;
}
