import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/processor_site.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin ProcessorSitesService implements BaseCollectionService {
  final _collectionName = 'processorSites';

  /// List Processor Sites
  ///
  /// Get a list of all the Appwrite [ProcessorSite] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<ProcessorSite>> listProcessorSites({
    List<String>? queries,
  }) async {
    List<ProcessorSite> results = [];
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
          results.add(ProcessorSite.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<ProcessorSite>.from(documentList.documents.map((document) => ProcessorSite.fromMap(document.data)));
  }

  /// Create Processor Site
  ///
  /// Create a new Appwrite [ProcessorSite] document.
  ///
  Future<ProcessorSite> createProcessorSite(
    ProcessorSite processorSite,
  ) async {
    Map data = processorSite.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: processorSite.$id,
      data: data,
      permissions: processorSite.$permissions,
    );

    return ProcessorSite.fromMap(document.data);
  }

  /// Get Processor Site
  ///
  /// Get an Appwrite [ProcessorSite] document by its unique ID.
  ///
  Future<ProcessorSite> getProcessorSite(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return ProcessorSite.fromMap(document.data);
  }

  /// Update Processor Site
  ///
  /// Update an Appwrite [ProcessorSite] document using the unique ID in the processorSite
  /// instance.
  ///
  Future<ProcessorSite> updateProcessorSite(
    ProcessorSite processorSite,
  ) async {
    Map data = processorSite.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: processorSite.$id,
      data: data,
      permissions: processorSite.$permissions,
    );

    return ProcessorSite.fromMap(document.data);
  }

  /// Delete Processor Site
  ///
  /// Delete an Appwrite [ProcessorSite] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteProcessorSite(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
