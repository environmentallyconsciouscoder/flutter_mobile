import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/models/carrier_vehicle.dart';
import 'package:limetrack/services/base/base_collection_service.dart';

mixin CarrierVehiclesService implements BaseCollectionService {
  final _collectionName = 'carrierVehicles';

  /// List Carrier Vehicles
  ///
  /// Get a list of all the Appwrite [CarrierVehicle] documents. You can use the
  /// query params to filter your results.
  ///
  Future<List<CarrierVehicle>> listCarrierVehicles({
    List<String>? queries,
  }) async {
    List<CarrierVehicle> results = [];
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
          results.add(CarrierVehicle.fromMap(document.data));
        }

        cursor = documentList.documents[documentList.documents.length - 1].$id;
      }
    } while (documentList.documents.length >= 100);

    return results;
    //return List<CarrierVehicle>.from(documentList.documents.map((document) => CarrierVehicle.fromMap(document.data)));
  }

  /// Create Carrier Vehicle
  ///
  /// Create a new Appwrite [CarrierVehicle] document.
  ///
  Future<CarrierVehicle> createCarrierVehicle(
    CarrierVehicle carrierVehicle,
  ) async {
    Map data = carrierVehicle.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    models.Document document = await databaseService.databases.createDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: carrierVehicle.$id,
      data: data,
      permissions: carrierVehicle.$permissions,
    );

    return CarrierVehicle.fromMap(document.data);
  }

  /// Get Carrier Vehicle
  ///
  /// Get an Appwrite [CarrierVehicle] document by its unique ID.
  ///
  Future<CarrierVehicle> getCarrierVehicle(
    String documentId,
  ) async {
    models.Document document = await databaseService.databases.getDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );

    return CarrierVehicle.fromMap(document.data);
  }

  /// Update Carrier Vehicle
  ///
  /// Update an Appwrite [CarrierVehicle] document using the unique ID in the carrierVehicle
  /// instance.
  ///
  Future<CarrierVehicle> updateCarrierVehicle(
    CarrierVehicle carrierVehicle,
  ) async {
    Map data = carrierVehicle.toMap();
    data.remove('\$id');
    data.remove('\$databaseId');
    data.remove('\$collectionId');
    data.remove('\$permissions');

    // increment revision count on update
    data['revision'] += 1;

    models.Document document = await databaseService.databases.updateDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: carrierVehicle.$id,
      data: data,
      permissions: carrierVehicle.$permissions,
    );

    return CarrierVehicle.fromMap(document.data);
  }

  /// Delete Carrier Vehicle
  ///
  /// Delete an Appwrite [CarrierVehicle] document by its unique ID. This only deletes
  /// the parent documents, its attributes and relations to other documents. Child
  /// documents **will not** be deleted.
  ///
  Future<void> deleteCarrierVehicle(
    String documentId,
  ) async {
    await databaseService.databases.deleteDocument(
      databaseId: 'default',
      collectionId: collectionLookups[_collectionName]!,
      documentId: documentId,
    );
  }
}
