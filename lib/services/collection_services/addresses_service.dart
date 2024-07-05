import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/address.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin AddressesService implements BaseCollectionService {
  final _collectionName = 'addresses';

  /// List Addresses
  ///
  /// Get a list of all the Appwrite [Address] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<Address>> listAddresses({
    List<String>? queries,
  }) async {
    List<Address> results = [];
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
          results.add(Address.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<Address>.from(documentList.documents.map((document) => Address.fromMap(document.data)));
  }

  /// Create Address
  ///
  /// Create a new Appwrite [Address] document.
  ///
  Future<Address> createAddress(
    Address address,
  ) async {
    Map data = address.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: address.$id,
      data: data,
      permissions: address.$permissions,
    );

    return Address.fromMap(document.data);
  }

  /// Get Address
  ///
  /// Get an Appwrite [Address] document by its unique ID.
  ///
  Future<Address> getAddress(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return Address.fromMap(document.data);
  }

  /// Update Address
  ///
  /// Update an Appwrite [Address] document using the unique ID in the address
  /// instance.
  ///
  Future<Address> updateAddress(
    Address address,
  ) async {
    Map data = address.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: address.$id,
      data: data,
      permissions: address.$permissions,
    );

    return Address.fromMap(document.data);
  }

  /// Delete Address
  ///
  /// Delete an Appwrite [Address] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteAddress(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
