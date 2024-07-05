import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/enums/caddy_size.dart';
import 'package:limetrack/enums/scan_mode.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/enums/waste_type.dart';
import 'package:limetrack/models/address.dart';
import 'package:limetrack/models/caddy.dart';
import 'package:limetrack/models/producer_site.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/services/database_service.dart';

class RegisterCaddyViewModel extends FormViewModel {
  final log = getLogger('RegisterCaddyViewModel');

  final navigationService = locator<NavigationService>();
  final snackbarService = locator<SnackbarService>();
  final collectionService = locator<CollectionService>();
  final databaseService = locator<DatabaseService>();

  final Caddy caddy;
  final ScanMode scanMode;

  String? addressId;
  List<Address> addresses = [];

  String size = CaddySize.l7.volume.toString();
  String wasteType = WasteType.general.appWriteEnum;

  RegisterCaddyViewModel({required this.caddy, required this.scanMode});

  @override
  void setFormStatus() {}

  void navigateBack() {
    navigationService.back();
  }

  Future<void> initialise() async {
    log.i('Initialising address list');

    List<String> addressList = [];

    // add the producerSites that the user has direct access to
    for (var producerSite in collectionService.producerSites!) {
      addressList.add(producerSite.siteAddressId);
    }

    log.v("Lookup addresses:${addressList.join(',')}");

    // get a list of all the addresses associated to the producer sites
    addresses = await collectionService.listAddresses(
      queries: [
        Query.equal('\$id', addressList),
      ],
    );

    addressId = addresses.first.$id;

    log.v('Addresses:$addresses');
    notifyListeners();
  }

  Future<void> saveData() async {
    log.i('Updating caddy details...');

    setBusy(true);

    caddy.$permissions = [
      Permission.read(Role.team(collectionService.team!.$id)),
      Permission.update(Role.team(collectionService.team!.$id)),
    ];

    try {
      List<ProducerSite> producerSites = await collectionService.listProducerSites(
        queries: [
          Query.equal('siteAddressId', addressId),
          Query.limit(100),
        ],
      );

      caddy.siteId = producerSites.first.$id;

      caddy.wasteType = WasteType.lookup(wasteType);

      CaddySize caddySize = CaddySize.lookupFromVolume(int.parse(size));
      caddy.volume = caddySize.volume;
      caddy.weight = caddySize.weight;

      Caddy updatedCaddy = await collectionService.updateCaddy(caddy);
      log.v('Caddy updated: $updatedCaddy');

      // if ScanMode.auto then we want to navigate back to
      // the bin deposit view...
      if (scanMode == ScanMode.auto) {
        navigationService.clearTillFirstAndShow(
          Routes.enterWeightView,
          arguments: EnterWeightViewArguments(caddy: caddy),
        );
      } else {
        // ...otherwise we want to return to the Dashboard
        navigationService.clearStackAndShow(Routes.homeView);
      }

      snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnGreen,
        title: 'THANK YOU',
        message: 'The caddy was successfully registered and is now ready for use.',
        duration: const Duration(seconds: 4),
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
