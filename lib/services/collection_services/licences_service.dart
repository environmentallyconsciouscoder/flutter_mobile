import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/licence.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin LicenceService implements BaseCollectionService {
  final _collectionName = 'licences';

  /// List Licences
  ///
  /// Get a list of all the Appwrite [Licence] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<Licence>> listLicences({
    List<String>? queries,
  }) async {
    List<Licence> results = [];
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
          results.add(Licence.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<Licence>.from(documentList.documents.map((document) => Licence.fromMap(document.data)));
  }

  /// Create Licence
  ///
  /// Create a new Appwrite [Licence] document.
  ///
  Future<Licence> createLicence(
    Licence licence,
  ) async {
    Map data = licence.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: licence.$id,
      data: data,
      permissions: licence.$permissions,
    );

    return Licence.fromMap(document.data);
  }

  /// Get Licence
  ///
  /// Get an Appwrite [Licence] document by its unique ID.
  ///
  Future<Licence> getLicence(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return Licence.fromMap(document.data);
  }

  /// Update Licence
  ///
  /// Update an Appwrite [Licence] document using the unique ID in the licence
  /// instance.
  ///
  Future<Licence> updateLicence(
    Licence licence,
  ) async {
    Map data = licence.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: licence.$id,
      data: data,
      permissions: licence.$permissions,
    );

    return Licence.fromMap(document.data);
  }

  /// Delete Licence
  ///
  /// Delete an Appwrite [Licence] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteLicence(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
