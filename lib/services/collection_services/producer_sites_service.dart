import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/producer_site.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin ProducerSitesService implements BaseCollectionService {
  final _collectionName = 'producerSites';

  /// List Producer Sites
  ///
  /// Get a list of all the Appwrite [ProducerSite] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<ProducerSite>> listProducerSites({
    List<String>? queries,
  }) async {
    List<ProducerSite> results = [];
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
          results.add(ProducerSite.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<ProducerSite>.from(documentList.documents.map((document) => ProducerSite.fromMap(document.data)));
  }

  /// Create Producer Site
  ///
  /// Create a new Appwrite [ProducerSite] document.
  ///
  Future<ProducerSite> createProducerSite(
    ProducerSite producerSite,
  ) async {
    Map data = producerSite.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: producerSite.$id,
      data: data,
      permissions: producerSite.$permissions,
    );

    return ProducerSite.fromMap(document.data);
  }

  /// Get Producer Site
  ///
  /// Get an Appwrite [ProducerSite] document by its unique ID.
  ///
  Future<ProducerSite> getProducerSite(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return ProducerSite.fromMap(document.data);
  }

  /// Update Producer Site
  ///
  /// Update an Appwrite [ProducerSite] document using the unique ID in the producerSite
  /// instance.
  ///
  Future<ProducerSite> updateProducerSite(
    ProducerSite producerSite,
  ) async {
    Map data = producerSite.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: producerSite.$id,
      data: data,
      permissions: producerSite.$permissions,
    );

    return ProducerSite.fromMap(document.data);
  }

  /// Delete Producer Site
  ///
  /// Delete an Appwrite [ProducerSite] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteProducerSite(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
