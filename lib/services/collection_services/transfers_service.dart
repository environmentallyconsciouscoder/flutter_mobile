import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/transfer.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin TransfersService implements BaseCollectionService {
  final _collectionName = 'transfers';

  /// List Transfers
  ///
  /// Get a list of all the Appwrite [Transfer] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<Transfer>> listTransfers({
    List<String>? queries,
  }) async {
    List<Transfer> results = [];
    models.DocumentList documentList;
    String? cursor;

    do {
      documentList = await databaseService.databases.listDocuments(
        databaseId: 'default',
        collectionId: collectionLookups[_collectionName]!,
        queries: [
          ...?queries,
          if (cursor != null) Query.cursorAfter(cursor),
          if (queries != null && !queries.any((word) => word.contains('limit('))) Query.limit(100),
        ],
      );

      if (documentList.documents.isNotEmpty) {
        for (models.Document document in documentList.documents) {
          results.add(Transfer.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<Transfer>.from(documentList.documents.map((document) => Transfer.fromMap(document.data)));
  }

  /// Create Transfer
  ///
  /// Create a new Appwrite [Transfer] document.
  ///
  Future<Transfer> createTransfer(
    Transfer transfer,
  ) async {
    Map data = transfer.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // utf8.encode() does not like null strings so at
    // worst, we will have to pass in a blank string
    String defraId = data['defraId'] as String? ?? '';
    String userId = data['userId'] as String? ?? '';
    String fromType = data['fromType'] as String? ?? '';
    String fromId = data['fromId'] as String? ?? '';
    String toType = data['toType'] as String? ?? '';
    String toId = data['toId'] as String? ?? '';
    String carrierVehicleId = data['carrierVehicleId'] as String? ?? '';
    String carrierVehicleDriver = data['carrierVehicleDriver'] as String? ?? '';
    String wasteCode = data['wasteCode'] as String? ?? '';
    String subCategory = data['subCategory'] as String? ?? '';
    String weight = data['weight'] != null ? (data['weight'] as int?).toString() : '';
    String geoLocation = data['geoLocation'] as String? ?? '';
    String timestamp = data['timestamp'] != null ? (data['timestamp'] as int?).toString() : '';
    String nextTransferId = data['nextTransferId'] as String? ?? '';
    String inferred = data['inferred'] != null ? (data['inferred'] as bool?).toString() : '';
    String wasteSource = data['wasteSource'] as String? ?? '';

    data['hash'] = sha256
        .convert(utf8.encode(defraId +
            userId +
            fromType +
            fromId +
            toType +
            toId +
            carrierVehicleId +
            carrierVehicleDriver +
            wasteCode +
            subCategory +
            weight +
            geoLocation +
            timestamp +
            nextTransferId +
            inferred +
            wasteSource))
        .toString();

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: transfer.$id,
      data: data,
      permissions: transfer.$permissions,
    );

    return Transfer.fromMap(document.data);
  }

  /// Get Transfer
  ///
  /// Get an Appwrite [Transfer] document by its unique ID.
  ///
  Future<Transfer> getTransfer(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return Transfer.fromMap(document.data);
  }

  /// Update Transfer
  ///
  /// Update an Appwrite [Transfer] document using the unique ID in the transfer
  /// instance.
  ///
  Future<Transfer> updateTransfer(
    Transfer transfer,
  ) async {
    Map data = transfer.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    // utf8.encode() does not like null strings so at
    // worst, we will have to pass in a blank string
    String defraId = data['defraId'] as String? ?? '';
    String userId = data['userId'] as String? ?? '';
    String fromType = data['fromType'] as String? ?? '';
    String fromId = data['fromId'] as String? ?? '';
    String toType = data['toType'] as String? ?? '';
    String toId = data['toId'] as String? ?? '';
    String carrierVehicleId = data['carrierVehicleId'] as String? ?? '';
    String carrierVehicleDriver = data['carrierVehicleDriver'] as String? ?? '';
    String wasteCode = data['wasteCode'] as String? ?? '';
    String subCategory = data['subCategory'] as String? ?? '';
    String weight = data['weight'] != null ? (data['weight'] as int?).toString() : '';
    String geoLocation = data['geoLocation'] as String? ?? '';
    String timestamp = data['timestamp'] != null ? (data['timestamp'] as int?).toString() : '';
    String nextTransferId = data['nextTransferId'] as String? ?? '';
    String inferred = data['inferred'] != null ? (data['inferred'] as bool?).toString() : '';
    String wasteSource = data['wasteSource'] as String? ?? '';

    data['hash'] = sha256
        .convert(utf8.encode(defraId +
            userId +
            fromType +
            fromId +
            toType +
            toId +
            carrierVehicleId +
            carrierVehicleDriver +
            wasteCode +
            subCategory +
            weight +
            geoLocation +
            timestamp +
            nextTransferId +
            inferred +
            wasteSource))
        .toString();

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: transfer.$id,
      data: data,
      permissions: transfer.$permissions,
    );

    return Transfer.fromMap(document.data);
  }

  /// Delete Transfer
  ///
  /// Delete an Appwrite [Transfer] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteTransfer(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
