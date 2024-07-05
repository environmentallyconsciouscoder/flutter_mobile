// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:limetrack/enums/site_type.dart';
import 'package:limetrack/models/shared/contact.dart';

class ProducerSite {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  int? numericId;
  String producerId;
  String siteAddressId;
  Contact contact;
  String? tradingAs;
  SiteType siteType;
  bool? canHostBinShare;
  List<String>? collectionDay;
  int? employees;
  int? revision;

  ProducerSite({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    this.numericId,
    required this.producerId,
    required this.siteAddressId,
    required this.contact,
    this.tradingAs,
    required this.siteType,
    this.canHostBinShare,
    this.collectionDay,
    this.employees,
    this.revision,
  });

  ProducerSite.instance({
    required this.$id,
    this.$permissions,
    this.numericId,
    required this.producerId,
    required this.siteAddressId,
    required this.contact,
    this.tradingAs,
    required this.siteType,
    this.canHostBinShare,
    this.collectionDay,
    this.employees,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  ProducerSite copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    int? numericId,
    String? producerId,
    String? siteAddressId,
    Contact? contact,
    String? tradingAs,
    SiteType? siteType,
    bool? canHostBinShare,
    List<String>? collectionDay,
    int? employees,
    int? revision,
  }) {
    return ProducerSite(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      numericId: numericId ?? this.numericId,
      producerId: producerId ?? this.producerId,
      siteAddressId: siteAddressId ?? this.siteAddressId,
      contact: contact ?? this.contact,
      tradingAs: tradingAs ?? this.tradingAs,
      siteType: siteType ?? this.siteType,
      canHostBinShare: canHostBinShare ?? this.canHostBinShare,
      collectionDay: collectionDay ?? this.collectionDay,
      employees: employees ?? this.employees,
      revision: revision ?? this.revision,
    );
  }

  factory ProducerSite.fromMap(Map<String, dynamic> map) {
    return ProducerSite(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      numericId: map['numericId'] as int?,
      producerId: map['producerId'] as String,
      siteAddressId: map['siteAddressId'] as String,
      contact: Contact.fromJson(map['contact']),
      tradingAs: map['tradingAs'] as String?,
      siteType: SiteType.lookup(map['siteType']),
      canHostBinShare: map['canHostBinShare'] as bool?,
      collectionDay: map['collectionDay'] != null ? List<String>.from(map['collectionDay']) : null,
      employees: map['employees'] as int?,
      revision: map['revision'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'numericId': numericId,
      'producerId': producerId,
      'siteAddressId': siteAddressId,
      'contact': contact.toJson(),
      'tradingAs': tradingAs,
      'siteType': siteType.appWriteEnum,
      'canHostBinShare': canHostBinShare,
      'collectionDay': collectionDay,
      'employees': employees,
      'revision': revision,
    };
  }

  factory ProducerSite.fromJson(String source) => ProducerSite.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ProducerSite(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, numericId: $numericId, producerId: $producerId, siteAddressId: $siteAddressId, '
        'contact: $contact, tradingAs: $tradingAs, siteType: $siteType, canHostBinShare: $canHostBinShare, '
        'collectionDay: $collectionDay, employees: $employees, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProducerSite &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.numericId == numericId &&
        other.producerId == producerId &&
        other.siteAddressId == siteAddressId &&
        other.contact == contact &&
        other.tradingAs == tradingAs &&
        other.siteType == siteType &&
        other.canHostBinShare == canHostBinShare &&
        listEquals(other.collectionDay, collectionDay) &&
        other.employees == employees &&
        other.revision == revision;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $databaseId.hashCode ^
        $collectionId.hashCode ^
        $permissions.hashCode ^
        numericId.hashCode ^
        producerId.hashCode ^
        siteAddressId.hashCode ^
        contact.hashCode ^
        tradingAs.hashCode ^
        siteType.hashCode ^
        canHostBinShare.hashCode ^
        collectionDay.hashCode ^
        employees.hashCode ^
        revision.hashCode;
  }
}
