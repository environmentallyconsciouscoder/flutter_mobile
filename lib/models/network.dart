// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class Network {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String hub;
  String satellite;
  int? priority;
  int? revision;

  Network({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    required this.hub,
    required this.satellite,
    this.priority,
    this.revision,
  });

  Network.instance({
    required this.$id,
    this.$permissions,
    required this.hub,
    required this.satellite,
    this.priority,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  Network copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? hub,
    String? satellite,
    int? priority,
    int? revision,
  }) {
    return Network(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      hub: hub ?? this.hub,
      satellite: satellite ?? this.satellite,
      priority: priority ?? this.priority,
      revision: revision ?? this.revision,
    );
  }

  factory Network.fromMap(Map<String, dynamic> map) {
    return Network(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      hub: map['hub'] as String,
      satellite: map['satellite'] as String,
      priority: map['priority'] as int?,
      revision: map['revision'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'hub': hub,
      'satellite': satellite,
      'priority': priority,
      'revision': revision,
    };
  }

  factory Network.fromJson(String source) => Network.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Transfer(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, hub: $hub, satellite: $satellite, priority: $priority, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Network &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.hub == hub &&
        other.satellite == satellite &&
        other.priority == priority &&
        other.revision == revision;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $databaseId.hashCode ^
        $collectionId.hashCode ^
        $permissions.hashCode ^
        hub.hashCode ^
        satellite.hashCode ^
        priority.hashCode ^
        revision.hashCode;
  }
}
