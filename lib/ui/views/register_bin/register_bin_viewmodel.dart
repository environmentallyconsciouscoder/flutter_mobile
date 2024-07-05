import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/enums/bin_type.dart';
import 'package:limetrack/enums/scan_mode.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/models/address.dart';
import 'package:limetrack/models/bin.dart';
import 'package:limetrack/models/producer_site.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/services/database_service.dart';

class RegisterBinViewModel extends FormViewModel {
  final log = getLogger('RegisterBinViewModel');

  final navigationService = locator<NavigationService>();
  final snackbarService = locator<SnackbarService>();
  final collectionService = locator<CollectionService>();
  final databaseService = locator<DatabaseService>();

  final Bin bin;
  final ScanMode scanMode;

  String? addressId;
  List<Address> addresses = [];

  String binType = BinType.hdpeWheelie.appWriteEnum;

  RegisterBinViewModel({required this.bin, required this.scanMode});

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

    // add the producerSites that the team has access to
    List<ProducerSite> additionalProducerSites = await collectionService.listProducerSites();

    if (additionalProducerSites.isNotEmpty) {
      for (var producerSite in additionalProducerSites) {
        if (!addressList.contains(producerSite.siteAddressId)) {
          addressList.add(producerSite.siteAddressId);
        }
      }
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
    log.i('Updating bin details...');

    setBusy(true);

    bin.$permissions = [
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

      bin.siteId = producerSites.first.$id;
      bin.binType = BinType.lookup(binType);

      Bin updatedBin = await collectionService.updateBin(bin);
      log.v('Bin updated: $updatedBin');

      // if ScanMode.auto then we want to navigate back to
      // the bin deposit view...
      if (scanMode == ScanMode.auto) {
        navigationService.clearTillFirstAndShow(
          Routes.enterDepositView,
          arguments: EnterDepositViewArguments(bin: bin),
        );
      } else {
        // ...otherwise we want to return to the Dashboard
        navigationService.clearStackAndShow(Routes.homeView);
      }

      snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnGreen,
        title: 'THANK YOU',
        message: 'The bin was successfully registered and is now ready for use.',
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
