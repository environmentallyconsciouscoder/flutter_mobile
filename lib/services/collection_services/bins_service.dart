import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/bin.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin BinsService implements BaseCollectionService {
  final _collectionName = 'bins';

  /// List Bins
  ///
  /// Get a list of all the Appwrite [Bin] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<Bin>> listBins({
    List<String>? queries,
  }) async {
    List<Bin> results = [];
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
          results.add(Bin.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<Bin>.from(documentList.documents.map((document) => Bin.fromMap(document.data)));
  }

  /// Create Bin
  ///
  /// Create a new Appwrite [Bin] document.
  ///
  Future<Bin> createBin(
    Bin bin,
  ) async {
    Map data = bin.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: bin.$id,
      data: data,
      permissions: bin.$permissions,
    );

    return Bin.fromMap(document.data);
  }

  /// Get Bin
  ///
  /// Get an Appwrite [Bin] document by its unique ID.
  ///
  Future<Bin> getBin(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return Bin.fromMap(document.data);
  }

  /// Update Bin
  ///
  /// Update an Appwrite [Bin] document using the unique ID in the bin
  /// instance.
  ///
  Future<Bin> updateBin(
    Bin bin,
  ) async {
    Map data = bin.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: bin.$id,
      data: data,
      permissions: bin.$permissions,
    );

    return Bin.fromMap(document.data);
  }

  /// Delete Bin
  ///
  /// Delete an Appwrite [Bin] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteBin(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
