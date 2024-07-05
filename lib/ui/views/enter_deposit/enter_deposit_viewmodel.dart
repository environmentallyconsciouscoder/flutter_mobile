import 'package:appwrite/appwrite.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/enums/entity_type.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/models/bin.dart';
import 'package:limetrack/models/transfer.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/services/location_service.dart';

class EnterDepositViewModel extends FormViewModel {
  final log = getLogger('EnterDepositViewModel');

  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final snackbarService = locator<SnackbarService>();
  final databaseService = locator<DatabaseService>();
  final collectionService = locator<CollectionService>();
  final locationService = locator<LocationService>();

  final Bin bin;

  Map<Transfer, bool> transfers = {};

  EnterDepositViewModel({required this.bin});

  bool get isContinueButtonEnabled {
    return transfers.isNotEmpty;
  }

  @override
  void setFormStatus() {}

  void navigateBack() {
    navigationService.back();
  }

  Future<void> getListOfDeposits() async {
    DateTime oldestTransactionTime = DateTime.now().subtract(const Duration(hours: 2)).toUtc();
    List<Transfer> allTransfers = [];
    List<Transfer> transferList = [];
    String? cursor;

    try {
      log.v('Get list of weights for deposit');

      do {
        transferList = await collectionService.listTransfers(
          queries: [
            Query.greaterThanEqual('timestamp', oldestTransactionTime.millisecondsSinceEpoch),
            Query.orderAsc('timestamp'),
            if (cursor != null) Query.cursorAfter(cursor),
            Query.limit(100),
          ],
        );

        if (transferList.isNotEmpty) {
          log.v('Adding ${transferList.length} elements to transfer list');

          allTransfers.addAll(transferList);
          cursor = transferList[transferList.length - 1].$id;
        }
      } while (transferList.length >= 100);

      // appwrite appears not to have the ability to query where an
      // attribute is null so we have to filter the list down manually
      transfers.clear();

      for (var transfer in allTransfers) {
        // need to include EntityType.producerSite for now - until
        // all old documents are converted to use EntityType.caddy
        if ((transfer.fromType == EntityType.caddy || transfer.fromType == EntityType.producerSite) &&
            transfer.toType == null &&
            transfer.nextTransferId == null) {
          transfers.addAll({transfer: true});
        }
      }
      notifyListeners();
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  void toggleTransferState(transfer, bool? value) {
    transfers[transfer] = value ?? false;
    notifyListeners();
  }

  Future<void> saveData() async {
    log.i('Form values:$formValueMap');
    log.i('Bin:$bin');

    try {
      setBusy(true);

      log.i('Geolocate device');
      Position position = await locationService.currentPosition();
      log.v('Position:$position');

      // loop through the selected deposits and create the
      // necessary companion transfer records
      for (var currentTransfer in transfers.keys) {
        if (transfers[currentTransfer] == true) {
          // create a new transfor for the chain of custody
          log.i('Creating transfer for ${currentTransfer.$id}');
          DateTime timestamp = DateTime.now().toUtc();
          Transfer newTransfer = await collectionService.createTransfer(
            Transfer.instance(
              $id: 'unique()',
              $permissions: [
                Permission.read(Role.team(collectionService.team!.$id)),
              ],
              userId: collectionService.account!.$id,
              fromType: currentTransfer.fromType,
              fromId: currentTransfer.fromId,
              toType: EntityType.bin,
              toId: bin.$id,
              wasteCode: '20 01 08',
              geoLocation: '${position.latitude},${position.longitude}',
              weight: currentTransfer.weight,
              volume: currentTransfer.volume ?? 0,
              timestamp: timestamp,
              dateTimeUtc: timestamp.toIso8601String(),
              inferred: false,
            ),
          );
          log.v('Transfer saved:$newTransfer');

          // update original transfer to link it to the new transfer
          log.i('Updating transfer:${currentTransfer.$id}');
          currentTransfer.nextTransferId = newTransfer.$id;
          Transfer updatedTransfer = await collectionService.updateTransfer(currentTransfer);
          log.v('Transfer updated:$updatedTransfer');

          collectionService.lastDeposited = newTransfer;
        }
      }

      // we're done depositing the food waste weight, go back to the home screen
      navigationService.clearStackAndShow(Routes.homeView);

      snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnGreen,
        title: 'THANK YOU',
        message: 'Your food waste deposit has been successfully recorded.',
        duration: const Duration(seconds: 4),
      );
    } on LocationException catch (error) {
      log.e(error.message);

      snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'ERROR',
        message: locationService.friendlyErrorMessage(error.message, error.enabled, error.permission),
        duration: const Duration(seconds: 6),
      );
    } on AppwriteException catch (error) {
      log.e(error.message);

      snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'ERROR',
        message: databaseService.friendlyErrorMessage(error.message),
        duration: const Duration(seconds: 6),
      );
    } catch (error) {
      // log any other errors so that we can look into them
      log.e(error);
    } finally {
      setBusy(false);
    }
  }
}
