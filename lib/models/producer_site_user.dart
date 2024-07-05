// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:limetrack/enums/user_role.dart';

class ProducerSiteUser {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String producerSiteId;
  String userId;
  UserRole? userRole;
  int? revision;

  ProducerSiteUser({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    required this.producerSiteId,
    required this.userId,
    this.userRole,
    this.revision,
  });

  ProducerSiteUser.instance({
    required this.$id,
    this.$permissions,
    required this.producerSiteId,
    required this.userId,
    this.userRole,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  ProducerSiteUser copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? producerSiteId,
    String? userId,
    UserRole? userRole,
    int? revision,
  }) {
    return ProducerSiteUser(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      producerSiteId: producerSiteId ?? this.producerSiteId,
      userId: userId ?? this.userId,
      userRole: userRole ?? this.userRole,
      revision: revision ?? this.revision,
    );
  }

  factory ProducerSiteUser.fromMap(Map<String, dynamic> map) {
    return ProducerSiteUser(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      producerSiteId: map['producerSiteId'] as String,
      userId: map['userId'] as String,
      userRole: map['role'] != null ? UserRole.lookup(map['role']) : null,
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
      'userId': userId,
      'role': userRole?.appWriteEnum,
      'revision': revision,
    };
  }

  factory ProducerSiteUser.fromJson(String source) => ProducerSiteUser.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ProducerSiteUser(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, producerSiteId: $producerSiteId, userId: $userId, userRole: $userRole, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProducerSiteUser &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.producerSiteId == producerSiteId &&
        other.userId == userId &&
        other.userRole == userRole &&
        other.revision == revision;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $databaseId.hashCode ^
        $collectionId.hashCode ^
        $permissions.hashCode ^
        producerSiteId.hashCode ^
        userId.hashCode ^
        userRole.hashCode ^
        revision.hashCode;
  }
}
