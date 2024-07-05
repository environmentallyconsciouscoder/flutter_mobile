import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/enums/bottom_sheet_type.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/services/environment_service.dart';
import 'package:limetrack/services/upgrader_service.dart';

class StartupViewModel extends BaseViewModel {
  final log = getLogger('StartupViewModel');
  final navigationService = locator<NavigationService>();
  final bottomSheetService = locator<BottomSheetService>();
  final collectionService = locator<CollectionService>();
  final databaseService = locator<DatabaseService>();
  final environmentService = locator<EnvironmentService>();
  final upgraderService = locator<UpgraderService>();

  bool _animationComplete = false;
  String? _destinationRoute;
  dynamic _destinationArguments;

  Future<void> runStartupLogic() async {
    log.i('Running startup logic');

    // initialise the EnvironmentService and ensure that the .env is loaded
    await environmentService.initialise();

    // initialise the Upgrader service
    await upgraderService.initialise();

    // initialise the Database service
    databaseService.initialise();

    bool collectionServiceInitialised = false;

    // initialise the Collection service and keep
    // retrying until we're able to get a connection
    do {
      try {
        await collectionService.initialise();

        collectionServiceInitialised = true;
      } catch (error) {
        log.e(error);

        await bottomSheetService.showCustomSheet(
          variant: BottomSheetType.floatingError,
          title: 'Error',
          description: 'Unable to connect to server. Please check your Internet connection.',
          mainButtonTitle: 'Retry',
          barrierDismissible: false,
        );
      }
    } while (!collectionServiceInitialised);

    // check if we have a logged in user and if they're assigned to a team
    collectionService.account = await databaseService.getCurrentAccount();
    collectionService.team = await databaseService.getAccountTeam();

    if (collectionService.isLoggedIn) {
      if (collectionService.hasTeam) {
        // get the list of producer sites that this user has access to
        await collectionService.getProducerSitesForUser();

        // get the recent activity
        await collectionService.recentActivity();

        // get the nearest bin share address
        await collectionService.getNearestBinShareAddress();

        // user is logged in and assigned to a team, go to the dashboard
        _replaceWith(route: Routes.homeView);
      } else {
        // user is not assigned to a team, allow the user to complete their registration
        _replaceWith(route: Routes.producerRegistrationView);
      }
    } else {
      // let's ask the user to log in
      _replaceWith(route: Routes.loginView);
    }
  }

  Future<void> _replaceWith({String? route, dynamic arguments}) async {
    _destinationRoute ??= route;
    _destinationArguments ??= arguments;

    // only navigate to the next route if the animation has
    // completed and we have a route to navigate to
    if (_animationComplete && _destinationRoute != null) {
      await navigationService.clearStackAndShow(
        _destinationRoute!,
        arguments: _destinationArguments,
      );
    }
  }

  Future<void> indicateAnimationComplete() async {
    _animationComplete = true;

    // if this is called after runStartupLogic() completes,
    // we want to continue with the navigation
    await _replaceWith();
  }
}
