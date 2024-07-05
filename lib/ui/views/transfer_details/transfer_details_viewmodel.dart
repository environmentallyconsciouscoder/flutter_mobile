import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/enums/entity_type.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/models/transfer.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/services/environment_service.dart';

import 'transfer_details.dart';

class TransferDetailsViewModel extends BaseViewModel {
  final log = getLogger('ReportsViewModel');
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final environmentService = locator<EnvironmentService>();
  final databaseService = locator<DatabaseService>();
  final collectionService = locator<CollectionService>();

  final List<TransferDetails> _transferDetailsList = [];
  List<TransferDetails> get transferDetailsList => _transferDetailsList;

  Future<void> runStartupLogic() async {
    List<Transfer>? transfers = await collectionService.listTransfers(
      queries: [
        Query.orderDesc('timestamp'),
      ],
    );

    for (var transfer in transfers) {
      // add the transfer if it is a weight
      if ((transfer.fromType == EntityType.caddy || (transfer.fromType == EntityType.producerSite && !transfer.inferred!)) &&
          transfer.toType == null) {
        _transferDetailsList.add(
          TransferDetails(
            transfer.$id,
            'weighed',
            transfer.weight!,
            transfer.timestamp,
            transfer.dateTimeUtc!,
            transfer.hash!,
          ),
        );
      }

      // add the transfer if it is a deposit
      if (transfer.toType == EntityType.bin && transfer.fromType != EntityType.producerSite) {
        _transferDetailsList.add(
          TransferDetails(
            transfer.$id,
            'deposited',
            transfer.weight!,
            transfer.timestamp,
            transfer.dateTimeUtc!,
            transfer.hash!,
          ),
        );
      }

      // add the transfer if it is a collection
      if (transfer.fromType == EntityType.bin && transfer.toType == EntityType.carrier) {
        _transferDetailsList.add(
          TransferDetails(
            transfer.$id,
            'collected',
            transfer.weight!,
            transfer.timestamp,
            transfer.dateTimeUtc!,
            transfer.hash!,
          ),
        );
      }

      // add the transfer if it is a transfer to AD
      if (transfer.fromType == EntityType.carrier && transfer.toType == EntityType.processorSite) {
        _transferDetailsList.add(
          TransferDetails(
            transfer.$id,
            'transferred to AD',
            transfer.weight!,
            transfer.timestamp,
            transfer.dateTimeUtc!,
            transfer.hash!,
          ),
        );
      }
    }

    notifyListeners();
  }

  void navigateBack() {
    navigationService.back();
  }
}
