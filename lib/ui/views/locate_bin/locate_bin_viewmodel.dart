import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/services/environment_service.dart';

class LocateBinViewModel extends BaseViewModel {
  final log = getLogger('LocateBinViewModel');
  final dialogService = locator<DialogService>();
  final environmentService = locator<EnvironmentService>();
  final databaseService = locator<DatabaseService>();

  Future<void> runStartupLogic() async {
    log.i('Running startup logic');

    log.v('Startup logic complete');
  }
}
