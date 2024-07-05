import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/processor.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin ProcessorsService implements BaseCollectionService {
  final _collectionName = 'processors';

  /// List Processors
  ///
  /// Get a list of all the Appwrite [Processor] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<Processor>> listProcessors({
    List<String>? queries,
  }) async {
    List<Processor> results = [];
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
          results.add(Processor.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<Processor>.from(documentList.documents.map((document) => Processor.fromMap(document.data)));
  }

  /// Create Processor
  ///
  /// Create a new Appwrite [Processor] document.
  ///
  Future<Processor> createProcessor(
    Processor processor,
  ) async {
    Map data = processor.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: processor.$id,
      data: data,
      permissions: processor.$permissions,
    );

    return Processor.fromMap(document.data);
  }

  /// Get Processor
  ///
  /// Get an Appwrite [Processor] document by its unique ID.
  ///
  Future<Processor> getProcessor(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return Processor.fromMap(document.data);
  }

  /// Update Processor
  ///
  /// Update an Appwrite [Processor] document using the unique ID in the processor
  /// instance.
  ///
  Future<Processor> updateProcessor(
    Processor processor,
  ) async {
    Map data = processor.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: processor.$id,
      data: data,
      permissions: processor.$permissions,
    );

    return Processor.fromMap(document.data);
  }

  /// Delete Processor
  ///
  /// Delete an Appwrite [Processor] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteProcessor(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
