//import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
// import 'package:limetrack/enums/dialog_type.dart';
// import 'package:limetrack/enums/snackbar_type.dart';
// import 'package:limetrack/services/database_service.dart';
// import 'package:limetrack/services/collection_service.dart';

class AccountManagementNotificationsViewModel extends BaseViewModel {
  final _log = getLogger('AccountManagementNotificationsViewModel');
  final _navigationService = locator<NavigationService>();
  // final _dialogService = locator<DialogService>();
  // final _snackbarService = locator<SnackbarService>();
  // final _databaseService = locator<DatabaseService>();
  // final _collectionService = locator<CollectionService>();

  Future<void> initialise() async {
    _log.i('Initialising');

    _log.i('Initialised');
  }

  void navigateBack() {
    _navigationService.back();
  }
}
