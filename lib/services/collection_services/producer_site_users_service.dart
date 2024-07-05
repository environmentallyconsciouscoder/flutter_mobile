import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/producer_site_user.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin ProducerSiteUsersService implements BaseCollectionService {
  final _collectionName = 'producerSiteUsers';

  /// List Producer Site Users
  ///
  /// Get a list of all the Appwrite [ProducerSiteUser] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<ProducerSiteUser>> listProducerSiteUsers({
    List<String>? queries,
  }) async {
    List<ProducerSiteUser> results = [];
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
          results.add(ProducerSiteUser.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<ProducerSiteUser>.from(documentList.documents.map((document) => ProducerSiteUser.fromMap(document.data)));
  }

  /// Create Producer Site User
  ///
  /// Create a new Appwrite [ProducerSiteUser] document.
  ///
  Future<ProducerSiteUser> createProducerSiteUser(
    ProducerSiteUser producerSiteUser,
  ) async {
    Map data = producerSiteUser.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: producerSiteUser.$id,
      data: data,
      permissions: producerSiteUser.$permissions,
    );

    return ProducerSiteUser.fromMap(document.data);
  }

  /// Get Producer Site User
  ///
  /// Get an Appwrite [ProducerSiteUser] document by its unique ID.
  ///
  Future<ProducerSiteUser> getProducerSiteUser(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return ProducerSiteUser.fromMap(document.data);
  }

  /// Update Producer Site User
  ///
  /// Update an Appwrite [ProducerSiteUser] document using the unique ID in the producerSiteUser
  /// instance.
  ///
  Future<ProducerSiteUser> updateProducerSiteUser(
    ProducerSiteUser producerSiteUser,
  ) async {
    Map data = producerSiteUser.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: producerSiteUser.$id,
      data: data,
      permissions: producerSiteUser.$permissions,
    );

    return ProducerSiteUser.fromMap(document.data);
  }

  /// Delete Producer Site User
  ///
  /// Delete an Appwrite [ProducerSiteUser] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteProducerSiteUser(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
