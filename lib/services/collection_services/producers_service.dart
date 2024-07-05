import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/producer.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin ProducersService implements BaseCollectionService {
  final _collectionName = 'producers';

  /// List Producers
  ///
  /// Get a list of all the Appwrite [Producer] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<Producer>> listProducers({
    List<String>? queries,
  }) async {
    List<Producer> results = [];
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
          results.add(Producer.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<Producer>.from(documentList.documents.map((document) => Producer.fromMap(document.data)));
  }

  /// Create Producer
  ///
  /// Create a new Appwrite [Producer] document.
  ///
  Future<Producer> createProducer(
    Producer producer,
  ) async {
    Map data = producer.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: producer.$id,
      data: data,
      permissions: producer.$permissions,
    );

    return Producer.fromMap(document.data);
  }

  /// Get Producer
  ///
  /// Get an Appwrite [Producer] document by its unique ID.
  ///
  Future<Producer> getProducer(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return Producer.fromMap(document.data);
  }

  /// Update Producer
  ///
  /// Update an Appwrite [Producer] document using the unique ID in the producer
  /// instance.
  ///
  Future<Producer> updateProducer(
    Producer producer,
  ) async {
    Map data = producer.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: producer.$id,
      data: data,
      permissions: producer.$permissions,
    );

    return Producer.fromMap(document.data);
  }

  /// Delete Producer
  ///
  /// Delete an Appwrite [Producer] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteProducer(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
