// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:limetrack/enums/company_type.dart';
import 'package:limetrack/models/shared/contact.dart';
import 'package:limetrack/models/shared/waste_exemption.dart';
import 'package:limetrack/models/shared/waste_registration.dart';

class Carrier {
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
  String? environmentPermitNumber;
  List<WasteExemption>? registeredWasteExemption;
  int? weightLimit;
  int? revision;

  Carrier({
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
    this.environmentPermitNumber,
    this.registeredWasteExemption,
    this.weightLimit,
    this.revision,
  });

  Carrier.instance({
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
    this.environmentPermitNumber,
    this.registeredWasteExemption,
    this.weightLimit,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  Carrier copyWith({
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
    String? environmentPermitNumber,
    List<WasteExemption>? registeredWasteExemption,
    int? weightLimit,
    int? revision,
  }) {
    return Carrier(
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
      environmentPermitNumber: environmentPermitNumber ?? this.environmentPermitNumber,
      registeredWasteExemption: registeredWasteExemption ?? this.registeredWasteExemption,
      weightLimit: weightLimit ?? this.weightLimit,
      revision: revision ?? this.revision,
    );
  }

  factory Carrier.fromMap(Map<String, dynamic> map) {
    return Carrier(
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
      environmentPermitNumber: map['environmentPermitNumber'] as String?,
      registeredWasteExemption: map['registeredWasteExemption'] != null
          ? List<WasteExemption>.from((map['registeredWasteExemption'] as List<dynamic>).map<WasteExemption>((x) => WasteExemption.fromJson(x)))
          : null,
      weightLimit: map['weightLimit'] as int?,
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
      'environmentPermitNumber': environmentPermitNumber,
      'registeredWasteExemption': registeredWasteExemption,
      'weightLimit': weightLimit,
      'revision': revision,
    };
  }

  factory Carrier.fromJson(String source) => Carrier.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Carrier(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, companyName: $companyName, companyNumber: $companyNumber, '
        'registeredAddressId: $registeredAddressId, companyType: $companyType, tradingAs: $tradingAs, '
        'natureOfBusiness: $natureOfBusiness, contact: $contact, wasteCarrierRegistration: $wasteCarrierRegistration, '
        'environmentPermitNumber: $environmentPermitNumber, registeredWasteExemption: $registeredWasteExemption, '
        'weightLimit: $weightLimit, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Carrier &&
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
        other.environmentPermitNumber == environmentPermitNumber &&
        listEquals(other.registeredWasteExemption, registeredWasteExemption) &&
        other.weightLimit == weightLimit &&
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
        environmentPermitNumber.hashCode ^
        registeredWasteExemption.hashCode ^
        weightLimit.hashCode ^
        revision.hashCode;
  }
}
