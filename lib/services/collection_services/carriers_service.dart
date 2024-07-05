import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/carrier.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin CarriersService implements BaseCollectionService {
  final _collectionName = 'carriers';

  /// List Carriers
  ///
  /// Get a list of all the Appwrite [Carrier] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<Carrier>> listCarriers({
    List<String>? queries,
  }) async {
    List<Carrier> results = [];
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
          results.add(Carrier.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<Carrier>.from(documentList.documents.map((document) => Carrier.fromMap(document.data)));
  }

  /// Create Carrier
  ///
  /// Create a new Appwrite [Carrier] document.
  ///
  Future<Carrier> createCarrier(
    Carrier carrier,
  ) async {
    Map data = carrier.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: carrier.$id,
      data: data,
      permissions: carrier.$permissions,
    );

    return Carrier.fromMap(document.data);
  }

  /// Get Carrier
  ///
  /// Get an Appwrite [Carrier] document by its unique ID.
  ///
  Future<Carrier> getCarrier(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return Carrier.fromMap(document.data);
  }

  /// Update Carrier
  ///
  /// Update an Appwrite [Carrier] document using the unique ID in the carrier
  /// instance.
  ///
  Future<Carrier> updateCarrier(
    Carrier carrier,
  ) async {
    Map data = carrier.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: carrier.$id,
      data: data,
      permissions: carrier.$permissions,
    );

    return Carrier.fromMap(document.data);
  }

  /// Delete Carrier
  ///
  /// Delete an Appwrite [Carrier] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteCarrier(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
