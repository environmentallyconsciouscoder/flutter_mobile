import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/network.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin NetworkService implements BaseCollectionService {
  final _collectionName = 'networks';

  /// List Networks
  ///
  /// Get a list of all the Appwrite [Network] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<Network>> listNetworks({
    List<String>? queries,
  }) async {
    List<Network> results = [];
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
          results.add(Network.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<Network>.from(documentList.documents.map((document) => Network.fromMap(document.data)));
  }

  /// Create Network
  ///
  /// Create a new Appwrite [Network] document.
  ///
  Future<Network> createNetwork(
    Network network,
  ) async {
    Map data = network.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: network.$id,
      data: data,
      permissions: network.$permissions,
    );

    return Network.fromMap(document.data);
  }

  /// Get Network
  ///
  /// Get an Appwrite [Network] document by its unique ID.
  ///
  Future<Network> getNetwork(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return Network.fromMap(document.data);
  }

  /// Update Network
  ///
  /// Update an Appwrite [Network] document using the unique ID in the network
  /// instance.
  ///
  Future<Network> updateNetwork(
    Network network,
  ) async {
    Map data = network.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: network.$id,
      data: data,
      permissions: network.$permissions,
    );

    return Network.fromMap(document.data);
  }

  /// Delete Network
  ///
  /// Delete an Appwrite [Network] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteNetwork(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
