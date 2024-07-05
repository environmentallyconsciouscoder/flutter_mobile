// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class Lookup {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String collectionName;
  String collectionId;

  Lookup({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    required this.collectionName,
    required this.collectionId,
  });

  Lookup.instance({
    required this.$id,
    this.$permissions,
    required this.collectionName,
    required this.collectionId,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  Lookup copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? collectionName,
    String? collectionId,
  }) {
    return Lookup(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      collectionName: collectionName ?? this.collectionName,
      collectionId: collectionId ?? this.collectionId,
    );
  }

  factory Lookup.fromMap(Map<String, dynamic> map) {
    return Lookup(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      collectionName: map['collectionName'] as String,
      collectionId: map['collectionId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'collectionName': collectionName,
      'collectionId': collectionId,
    };
  }

  factory Lookup.fromJson(String source) => Lookup.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Lookup(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, collectionName: $collectionName, collectionId: $collectionId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Lookup &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.collectionName == collectionName &&
        other.collectionId == collectionId;
  }

  @override
  int get hashCode {
    return $id.hashCode ^ $databaseId.hashCode ^ $collectionId.hashCode ^ $permissions.hashCode ^ collectionName.hashCode ^ collectionId.hashCode;
  }
}
