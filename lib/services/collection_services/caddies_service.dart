import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/caddy.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin CaddiesService implements BaseCollectionService {
  final _collectionName = 'caddies';

  /// List Caddies
  ///
  /// Get a list of all the Appwrite [Caddy] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<Caddy>> listCaddies({
    List<String>? queries,
  }) async {
    List<Caddy> results = [];
    models.DocumentList documentList;
    String? cursor;

    do {
      documentList = await databaseService.databases.listDocuments(
        databaseId: 'default',
        collectionId: collectionLookups[_collectionName]!,
        queries: [
          ...?queries,
          if (cursor != null) Query.cursorAfter(cursor),
          if (queries != null &&
              !queries.any((word) => word.contains('limit(')))
            Query.limit(100),
        ],
      );

      if (documentList.documents.isNotEmpty) {
        for (models.Document document in documentList.documents) {
          results.add(Caddy.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<Caddy>.from(documentList.documents.map((document) => Caddy.fromMap(document.data)));
  }

  /// Create Caddy
  ///
  /// Create a new Appwrite [Caddy] document.
  ///
  Future<Caddy> createCaddy(
    Caddy caddy,
  ) async {
    Map data = caddy.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: caddy.$id,
      data: data,
      permissions: caddy.$permissions,
    );

    return Caddy.fromMap(document.data);
  }

  /// Get Caddy
  ///
  /// Get an Appwrite [Caddy] document by its unique ID.
  ///
  Future<Caddy> getCaddy(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return Caddy.fromMap(document.data);
  }

  /// Update Caddy
  ///
  /// Update an Appwrite [Caddy] document using the unique ID in the caddy
  /// instance.
  ///
  Future<Caddy> updateCaddy(
    Caddy caddy,
  ) async {
    Map data = caddy.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: caddy.$id,
      data: data,
      permissions: caddy.$permissions,
    );

    return Caddy.fromMap(document.data);
  }

  /// Delete Caddy
  ///
  /// Delete an Appwrite [Caddy] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteCaddy(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
