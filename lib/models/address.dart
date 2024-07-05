// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class Address {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String line1;
  String? line2;
  String? line3;
  String? town;
  String postcode;
  String? country;
  int? revision;

  Address({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    required this.line1,
    this.line2,
    this.line3,
    this.town,
    required this.postcode,
    this.country,
    this.revision,
  });

  Address.instance({
    required this.$id,
    this.$permissions,
    required this.line1,
    this.line2,
    this.line3,
    this.town,
    required this.postcode,
    this.country,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  Address copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? line1,
    String? line2,
    String? line3,
    String? town,
    String? postcode,
    String? country,
    int? revision,
  }) {
    return Address(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      line3: line3 ?? this.line3,
      town: town ?? this.town,
      postcode: postcode ?? this.postcode,
      country: country ?? this.country,
      revision: revision ?? this.revision,
    );
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      line1: map['line1'] as String,
      line2: map['line2'] as String?,
      line3: map['line3'] as String?,
      town: map['town'] as String?,
      postcode: map['postcode'] as String,
      country: map['country'] as String?,
      revision: map['revision'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'line1': line1,
      'line2': line2,
      'line3': line3,
      'town': town,
      'postcode': postcode,
      'country': country,
      'revision': revision,
    };
  }

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Address(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, line1: $line1, line2: $line2, line3: $line3, town: $town, '
        'postcode: $postcode, country: $country, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.line1 == line1 &&
        other.line2 == line2 &&
        other.line3 == line3 &&
        other.town == town &&
        other.postcode == postcode &&
        other.country == country &&
        other.revision == revision;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $databaseId.hashCode ^
        $collectionId.hashCode ^
        $permissions.hashCode ^
        line1.hashCode ^
        line2.hashCode ^
        line3.hashCode ^
        town.hashCode ^
        postcode.hashCode ^
        country.hashCode ^
        revision.hashCode;
  }
}
