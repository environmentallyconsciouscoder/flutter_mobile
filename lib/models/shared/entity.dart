// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:limetrack/enums/entity_type.dart';

class Entity {
  String id;
  EntityType type;

  Entity({
    required this.id,
    required this.type,
  });

  Entity copyWith({
    String? id,
    EntityType? type,
  }) {
    return Entity(
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }

  factory Entity.fromMap(Map<String, dynamic> map) {
    return Entity(
      id: map['id'] as String,
      type: EntityType.values.byName(map['type']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.name,
    };
  }

  factory Entity.fromJson(String source) => Entity.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Entity(id: $id, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Entity && other.id == id && other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ type.hashCode;
  }
}
