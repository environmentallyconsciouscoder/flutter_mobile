// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:limetrack/enums/company_type.dart';
import 'package:limetrack/models/shared/contact.dart';
import 'package:limetrack/models/shared/waste_registration.dart';

class Producer {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String companyName;
  String? companyNumber;
  String registeredAddressId;
  CompanyType? companyType;
  String? tradingAs;
  List<String>? natureOfBusiness;
  Contact contact;
  WasteRegistration? wasteCarrierRegistration;
  int? revision;

  Producer({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    required this.companyName,
    this.companyNumber,
    required this.registeredAddressId,
    this.companyType,
    this.tradingAs,
    this.natureOfBusiness,
    required this.contact,
    this.wasteCarrierRegistration,
    this.revision,
  });

  Producer.instance({
    required this.$id,
    this.$permissions,
    required this.companyName,
    this.companyNumber,
    required this.registeredAddressId,
    this.companyType,
    this.tradingAs,
    this.natureOfBusiness,
    required this.contact,
    this.wasteCarrierRegistration,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  Producer copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? companyName,
    String? companyNumber,
    String? registeredAddressId,
    CompanyType? companyType,
    String? tradingAs,
    List<String>? natureOfBusiness,
    Contact? contact,
    WasteRegistration? wasteCarrierRegistration,
    int? revision,
  }) {
    return Producer(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      companyName: companyName ?? this.companyName,
      companyNumber: companyNumber ?? this.companyNumber,
      registeredAddressId: registeredAddressId ?? this.registeredAddressId,
      companyType: companyType ?? this.companyType,
      tradingAs: tradingAs ?? this.tradingAs,
      natureOfBusiness: natureOfBusiness ?? this.natureOfBusiness,
      contact: contact ?? this.contact,
      wasteCarrierRegistration: wasteCarrierRegistration ?? this.wasteCarrierRegistration,
      revision: revision ?? this.revision,
    );
  }

  factory Producer.fromMap(Map<String, dynamic> map) {
    return Producer(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      companyName: map['companyName'] as String,
      companyNumber: map['companyNumber'] as String?,
      registeredAddressId: map['registeredAddressId'] as String,
      companyType: map['companyType'] != null ? CompanyType.lookup(map['companyType']) : null,
      tradingAs: map['tradingAs'] as String?,
      natureOfBusiness: map['natureOfBusiness'] != null ? List<String>.from(map['natureOfBusiness']) : null,
      contact: Contact.fromJson(map['contact']),
      wasteCarrierRegistration: map['wasteCarrierRegistration'] != null ? WasteRegistration.fromJson(map['wasteCarrierRegistration']) : null,
      revision: map['revision'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'companyName': companyName,
      'companyNumber': companyNumber,
      'registeredAddressId': registeredAddressId,
      'companyType': companyType?.appWriteEnum,
      'tradingAs': tradingAs,
      'natureOfBusiness': natureOfBusiness,
      'contact': contact.toJson(),
      'wasteCarrierRegistration': wasteCarrierRegistration?.toJson(),
      'revision': revision,
    };
  }

  factory Producer.fromJson(String source) => Producer.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Producer(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, companyName: $companyName, companyNumber: $companyNumber, '
        'registeredAddressId: $registeredAddressId, companyType: $companyType, tradingAs: $tradingAs, '
        'natureOfBusiness: $natureOfBusiness, contact: $contact, wasteCarrierRegistration: $wasteCarrierRegistration, '
        'revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Producer &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.companyName == companyName &&
        other.companyNumber == companyNumber &&
        other.registeredAddressId == registeredAddressId &&
        other.companyType == companyType &&
        other.tradingAs == tradingAs &&
        listEquals(other.natureOfBusiness, natureOfBusiness) &&
        other.contact == contact &&
        other.wasteCarrierRegistration == wasteCarrierRegistration &&
        other.revision == revision;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $databaseId.hashCode ^
        $collectionId.hashCode ^
        $permissions.hashCode ^
        companyName.hashCode ^
        companyNumber.hashCode ^
        registeredAddressId.hashCode ^
        companyType.hashCode ^
        tradingAs.hashCode ^
        natureOfBusiness.hashCode ^
        contact.hashCode ^
        wasteCarrierRegistration.hashCode ^
        revision.hashCode;
  }
}
