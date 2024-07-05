import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/lookup.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin LookupsService implements BaseCollectionService {
  final _collectionName = 'lookups';

  /// List Lookups
  ///
  /// Get a list of all the Appwrite [Lookup] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<Lookup>> listLookups({
    List<String>? queries,
  }) async {
    List<Lookup> results = [];
    models.DocumentList documentList;
    String? cursor;

    do {
      documentList = await databaseService.databases.listDocuments(
        databaseId: 'default',
        collectionId: _collectionName,
        queries: [
          ...?queries,
          if (cursor != null) Query.cursorAfter(cursor),
          if (queries != null && !queries.any((word) => word.contains('limit('))) Query.limit(100),
        ],
      );

      if (documentList.documents.isNotEmpty) {
        for (models.Document document in documentList.documents) {
          results.add(Lookup.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<Lookup>.from(documentList.documents.map((document) => Lookup.fromMap(document.data)));
  }

  /// Get Lookup
  ///
  /// Get an Appwrite [Lookup] document by its unique ID.
  ///
  Future<Lookup> getLookup(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: _collectionName,
      documentId: documentId,
    );

    return Lookup.fromMap(document.data);
  }
}
