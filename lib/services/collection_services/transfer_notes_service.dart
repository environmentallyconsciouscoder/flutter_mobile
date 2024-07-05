import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/transfer_note.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin TransferNotesService implements BaseCollectionService {
  final _collectionName = 'transferNotes';

  /// List TransferNotes
  ///
  /// Get a list of all the Appwrite [TransferNote] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<TransferNote>> listTransferNotes({
    List<String>? queries,
  }) async {
    List<TransferNote> results = [];
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
          results.add(TransferNote.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<TransferNote>.from(documentList.documents.map((document) => TransferNote.fromMap(document.data)));
  }

  /// Create TransferNote
  ///
  /// Create a new Appwrite [TransferNote] document.
  ///
  Future<TransferNote> createTransferNote(
    TransferNote transferNote,
  ) async {
    Map data = transferNote.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: transferNote.$id,
      data: data,
      permissions: transferNote.$permissions,
    );

    return TransferNote.fromMap(document.data);
  }

  /// Get TransferNote
  ///
  /// Get an Appwrite [TransferNote] document by its unique ID.
  ///
  Future<TransferNote> getTransferNote(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return TransferNote.fromMap(document.data);
  }

  /// Update TransferNote
  ///
  /// Update an Appwrite [TransferNote] document using the unique ID in the transferNote
  /// instance.
  ///
  Future<TransferNote> updateTransferNote(
    TransferNote transferNote,
  ) async {
    Map data = transferNote.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: transferNote.$id,
      data: data,
      permissions: transferNote.$permissions,
    );

    return TransferNote.fromMap(document.data);
  }

  /// Delete TransferNote
  ///
  /// Delete an Appwrite [TransferNote] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteTransferNote(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
