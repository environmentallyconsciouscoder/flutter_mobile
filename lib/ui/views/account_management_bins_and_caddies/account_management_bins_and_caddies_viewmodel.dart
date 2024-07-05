import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/enums/scan_mode.dart';
import 'package:limetrack/services/collection_service.dart';

class AccountManagementBinsAndCaddiesViewModel extends BaseViewModel {
  final _log = getLogger('AccountManagementBinsAndCaddiesViewModel');
  final _navigationService = locator<NavigationService>();
  final _collectionService = locator<CollectionService>();

  bool get canHostBinShare {
    return _collectionService.producerSites?.first.canHostBinShare ?? false;
  }

  Future<void> initialise() async {
    _log.i('Initialising');

    _log.i('Initialised');
  }

  void navigateBack() {
    _navigationService.back();
  }

  Future<void> registerNewBin() async {
    _navigationService.navigateTo(Routes.scanView, arguments: const ScanViewArguments(scanMode: ScanMode.bin));
  }

  Future<void> registerNewCaddy() async {
    _navigationService.navigateTo(Routes.scanView, arguments: const ScanViewArguments(scanMode: ScanMode.caddy));
  }
}
