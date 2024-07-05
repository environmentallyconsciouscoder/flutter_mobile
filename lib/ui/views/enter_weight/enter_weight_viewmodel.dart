import 'package:appwrite/appwrite.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/enums/entity_type.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/models/caddy.dart';
import 'package:limetrack/models/transfer.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/services/location_service.dart';

import 'enter_weight_view.form.dart';

class EnterWeightViewModel extends FormViewModel {
  final log = getLogger('EnterWeightViewModel');

  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final snackbarService = locator<SnackbarService>();
  final databaseService = locator<DatabaseService>();
  final collectionService = locator<CollectionService>();
  final locationService = locator<LocationService>();

  final Caddy caddy;

  EnterWeightViewModel({required this.caddy});

  String? get getWeightErrorText {
    if (weightValue != null && weightValue!.trim().isEmpty) {
      return 'required';
    }

    // assume the min and max weight for a 20l caddy
    double minWeight = 1.0;
    double maxWeight = 21.0;

    // approximate the theoretical minimum and maximum
    // weight for the caddy
    if (caddy.weight != null && caddy.volume != null) {
      minWeight = caddy.weight! / 1000;
      maxWeight = (caddy.weight! + caddy.volume!) / 1000;
    }

    double enteredWeight = double.tryParse(weightValue!.trim()) ?? 0;

    if (weightValue != null && enteredWeight < minWeight) {
      return 'seems a little light - are you weighing caddy and contents?';
    }

    if (weightValue != null && enteredWeight > maxWeight) {
      return 'seems a little too heavy?';
    }

    return null;
  }

  bool get isContinueButtonEnabled {
    double maxWeight = 21;

    if (caddy.weight != null && caddy.volume != null) {
      maxWeight = (caddy.weight! + caddy.volume!) / 1000;
    }

    double enteredWeight = double.tryParse(weightValue!.trim()) ?? 0;

    return (weightValue != null && weightValue!.trim().isNotEmpty && enteredWeight <= maxWeight);
  }

  @override
  void setFormStatus() {}

  void navigateBack() {
    navigationService.back();
  }

  Future<void> saveData() async {
    log.i('Form values:$formValueMap');
    log.i('Caddy:$caddy');

    try {
      setBusy(true);

      log.i('Geolocate device');
      Position position = await locationService.currentPosition();
      log.v('Position:$position');

      log.i('Creating transfer');

      DateTime timestamp = DateTime.now().toUtc();
      double enteredWeight = double.tryParse(weightValue!.trim()) ?? 0;

      Transfer transfer = await collectionService.createTransfer(
        Transfer.instance(
          $id: 'unique()',
          $permissions: [
            Permission.read(Role.team(collectionService.team!.$id)),
            Permission.update(Role.team(collectionService.team!.$id)),
          ],
          userId: collectionService.account!.$id,
          fromType: EntityType.caddy,
          fromId: caddy.$id,
          wasteCode: '20 01 08',
          geoLocation: '${position.latitude},${position.longitude}',
          weight: enteredWeight > 0 ? (enteredWeight * 1000).toInt() - caddy.weight! : null,
          timestamp: timestamp,
          dateTimeUtc: timestamp.toIso8601String(),
          inferred: false,
        ),
      );
      log.v('Transfer saved:$transfer');

      // we're done saving the food waste weight, update the total
      // weight saved and then go back to the home screen
      collectionService.totalWeighed += transfer.weight ?? 00;
      collectionService.lastWeighed = transfer;

      // we're done weighing the food waste, go back to the home screen
      navigationService.clearStackAndShow(Routes.homeView);

      snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnGreen,
        title: 'THANK YOU',
        message: 'Your food waste weight has been successfully recorded.',
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
