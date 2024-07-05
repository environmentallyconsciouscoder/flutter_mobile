import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/producer_existing_contract.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin ProducerExistingContractsService implements BaseCollectionService {
  final _collectionName = 'producerExistingContracts';

  /// List Producer Existing Contracts
  ///
  /// Get a list of all the Appwrite [ProducerExistingContract] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<ProducerExistingContract>> listProducerExistingContracts({
    List<String>? queries,
  }) async {
    List<ProducerExistingContract> results = [];
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
          results.add(ProducerExistingContract.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<ProducerExistingContract>.from(documentList.documents.map((document) => ProducerExistingContract.fromMap(document.data)));
  }

  /// Create Producer Existing Contract
  ///
  /// Create a new Appwrite [ProducerExistingContract] document.
  ///
  Future<ProducerExistingContract> createProducerExistingContract(
    ProducerExistingContract producerExistingContract,
  ) async {
    Map data = producerExistingContract.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: producerExistingContract.$id,
      data: data,
      permissions: producerExistingContract.$permissions,
    );

    return ProducerExistingContract.fromMap(document.data);
  }

  /// Get Producer Existing Contract
  ///
  /// Get an Appwrite [ProducerExistingContract] document by its unique ID.
  ///
  Future<ProducerExistingContract> getProducerExistingContract(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return ProducerExistingContract.fromMap(document.data);
  }

  /// Update Producer Existing Contract
  ///
  /// Update an Appwrite [ProducerExistingContract] document using the unique ID in the producerExistingContract
  /// instance.
  ///
  Future<ProducerExistingContract> updateProducerExistingContract(
    ProducerExistingContract producerExistingContract,
  ) async {
    Map data = producerExistingContract.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: producerExistingContract.$id,
      data: data,
      permissions: producerExistingContract.$permissions,
    );

    return ProducerExistingContract.fromMap(document.data);
  }

  /// Delete Producer Existing Contract
  ///
  /// Delete an Appwrite [ProducerExistingContract] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteProducerExistingContract(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
