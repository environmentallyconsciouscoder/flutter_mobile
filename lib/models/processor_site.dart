// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:limetrack/models/shared/contact.dart';
import 'package:limetrack/models/shared/product.dart';
import 'package:limetrack/models/shared/waste_registration.dart';

class ProcessorSite {
  String $id;
  String $databaseId;
  String $collectionId;
  List<String>? $permissions;
  String processorId;
  String siteAddressId;
  Contact contact;
  String? tradingAs;
  WasteRegistration? wasteDealerRegistration;
  String? animalHealthLicenceNumber;
  List<Product>? output;
  int? revision;

  ProcessorSite({
    required this.$id,
    required this.$databaseId,
    required this.$collectionId,
    this.$permissions,
    required this.processorId,
    required this.siteAddressId,
    required this.contact,
    this.tradingAs,
    this.wasteDealerRegistration,
    this.animalHealthLicenceNumber,
    this.output,
    this.revision,
  });

  ProcessorSite.instance({
    required this.$id,
    this.$permissions,
    required this.processorId,
    required this.siteAddressId,
    required this.contact,
    this.tradingAs,
    this.wasteDealerRegistration,
    this.animalHealthLicenceNumber,
    this.output,
    this.revision,
  })  : $databaseId = 'default',
        $collectionId = 'current';

  ProcessorSite copyWith({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    List<String>? $permissions,
    String? processorId,
    String? siteAddressId,
    Contact? contact,
    String? tradingAs,
    WasteRegistration? wasteDealerRegistration,
    String? animalHealthLicenceNumber,
    List<Product>? output,
    int? revision,
  }) {
    return ProcessorSite(
      $id: $id ?? this.$id,
      $databaseId: $databaseId ?? this.$databaseId,
      $collectionId: $collectionId ?? this.$collectionId,
      $permissions: $permissions ?? this.$permissions,
      processorId: processorId ?? this.processorId,
      siteAddressId: siteAddressId ?? this.siteAddressId,
      contact: contact ?? this.contact,
      tradingAs: tradingAs ?? this.tradingAs,
      wasteDealerRegistration: wasteDealerRegistration ?? this.wasteDealerRegistration,
      animalHealthLicenceNumber: animalHealthLicenceNumber ?? this.animalHealthLicenceNumber,
      output: output ?? this.output,
      revision: revision ?? this.revision,
    );
  }

  factory ProcessorSite.fromMap(Map<String, dynamic> map) {
    return ProcessorSite(
      $id: map['\$id'] as String,
      $databaseId: map['\$databaseId'] as String,
      $collectionId: map['\$collectionId'] as String,
      $permissions: map['\$permisions'] as List<String>?,
      processorId: map['processorId'] as String,
      siteAddressId: map['siteAddressId'] as String,
      contact: Contact.fromJson(map['contact']),
      tradingAs: map['tradingAs'] as String?,
      wasteDealerRegistration: map['wasteDealerRegistration'] != null ? WasteRegistration.fromJson(map['wasteDealerRegistration']) : null,
      animalHealthLicenceNumber: map['animalHealthLicenceNumber'] as String?,
      output: map['output'] != null ? List<Product>.from((map['output'] as List<dynamic>).map<Product>((x) => Product.fromJson(x))) : null,
      revision: map['revision'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': $id,
      '\$databaseId': $databaseId,
      '\$collectionId': $collectionId,
      '\$permissions': $permissions,
      'processorId': processorId,
      'siteAddressId': siteAddressId,
      'contact': contact.toJson(),
      'tradingAs': tradingAs,
      'wasteDealerRegistration': wasteDealerRegistration?.toJson(),
      'animalHealthLicenceNumber': animalHealthLicenceNumber,
      'output': output,
      'revision': revision,
    };
  }

  factory ProcessorSite.fromJson(String source) => ProcessorSite.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ProcessorSite(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, '
        '\$permissions: ${$permissions}, processorId: $processorId, siteAddressId: $siteAddressId, contact: $contact, '
        'tradingAs: $tradingAs, wasteDealerRegistration: $wasteDealerRegistration, '
        'animalHealthLicenceNumber: $animalHealthLicenceNumber, output: $output, revision: $revision)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProcessorSite &&
        other.$id == $id &&
        other.$databaseId == $databaseId &&
        other.$collectionId == $collectionId &&
        listEquals(other.$permissions, $permissions) &&
        other.processorId == processorId &&
        other.siteAddressId == siteAddressId &&
        other.contact == contact &&
        other.tradingAs == tradingAs &&
        other.wasteDealerRegistration == wasteDealerRegistration &&
        other.animalHealthLicenceNumber == animalHealthLicenceNumber &&
        listEquals(other.output, output) &&
        other.revision == revision;
  }

  @override
  int get hashCode {
    return $id.hashCode ^
        $databaseId.hashCode ^
        $collectionId.hashCode ^
        $permissions.hashCode ^
        processorId.hashCode ^
        siteAddressId.hashCode ^
        contact.hashCode ^
        tradingAs.hashCode ^
        wasteDealerRegistration.hashCode ^
        animalHealthLicenceNumber.hashCode ^
        output.hashCode ^
        revision.hashCode;
  }
}
