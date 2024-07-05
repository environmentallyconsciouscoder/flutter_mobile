import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/services/environment_service.dart';
import 'package:limetrack/services/location_service.dart';
import 'package:limetrack/services/upgrader_service.dart';
import 'package:limetrack/ui/views/account/account_view.dart';
import 'package:limetrack/ui/views/account_management/account_management_view.dart';
import 'package:limetrack/ui/views/account_management_bins_and_caddies/account_management_bins_and_caddies_view.dart';
import 'package:limetrack/ui/views/account_management_liners/account_management_liners_view.dart';
import 'package:limetrack/ui/views/account_management_notifications/account_management_notifications_view.dart';
import 'package:limetrack/ui/views/account_management_team/account_management_team_view.dart';
import 'package:limetrack/ui/views/enter_deposit/enter_deposit_view.dart';
import 'package:limetrack/ui/views/enter_weight/enter_weight_view.dart';
import 'package:limetrack/ui/views/forgot_password/forgot_password_view.dart';
import 'package:limetrack/ui/views/home/home_view.dart';
import 'package:limetrack/ui/views/locate_bin/locate_bin_view.dart';
import 'package:limetrack/ui/views/login/login_view.dart';
import 'package:limetrack/ui/views/producer_registration/producer_registration_view.dart';
import 'package:limetrack/ui/views/producer_site_registration/producer_site_registration_view.dart';
import 'package:limetrack/ui/views/register/register_view.dart';
import 'package:limetrack/ui/views/register_bin/register_bin_view.dart';
import 'package:limetrack/ui/views/register_caddy/register_caddy_view.dart';
import 'package:limetrack/ui/views/reports/reports_view.dart';
import 'package:limetrack/ui/views/scan/scan_view.dart';
import 'package:limetrack/ui/views/share/share_view.dart';
import 'package:limetrack/ui/views/startup/startup_view.dart';
import 'package:limetrack/ui/views/transfer_details/transfer_details_view.dart';
// @stacked-import

import 'custom_route_transition.dart';

@StackedApp(
  routes: [
    AdaptiveRoute(page: StartupView),
    AdaptiveRoute(page: AccountView),
    AdaptiveRoute(page: AccountManagementView),
    AdaptiveRoute(page: AccountManagementBinsAndCaddiesView),
    AdaptiveRoute(page: AccountManagementLinersView),
    AdaptiveRoute(page: AccountManagementNotificationsView),
    AdaptiveRoute(page: AccountManagementTeamView),
    AdaptiveRoute(page: EnterDepositView),
    AdaptiveRoute(page: EnterWeightView),
    AdaptiveRoute(page: ForgotPasswordView),
    CustomRoute(
      page: HomeView,
      transitionsBuilder: CustomRouteTransition.sharedAxisScaled,
      durationInMilliseconds: 550,
      reverseDurationInMilliseconds: 350,
    ),
    AdaptiveRoute(page: LocateBinView),
    AdaptiveRoute(page: LoginView),
    AdaptiveRoute(page: ProducerRegistrationView),
    AdaptiveRoute(page: ProducerSiteRegistrationView),
    AdaptiveRoute(page: RegisterView),
    AdaptiveRoute(page: RegisterBinView),
    AdaptiveRoute(page: RegisterCaddyView),
    AdaptiveRoute(page: ReportsView),
    AdaptiveRoute(page: ScanView),
    AdaptiveRoute(page: ShareView),
    AdaptiveRoute(page: TransferDetailsView),
// @stacked-route
  ],
  dependencies: [
    // built in Stacked services
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    // bespoke application services
    LazySingleton(classType: CollectionService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: EnvironmentService),
    LazySingleton(classType: LocationService),
    LazySingleton(classType: UpgraderService),
// @stacked-service
  ],
  logger: StackedLogger(),
)
class App {
  /** Serves no purpose besides having an annotation attached to it */

  /*
    Cleaning up Flutter
      flutter clean
      flutter pub get
      flutter pub run build_runner build --delete-conflicting-outputs
    
    Check builds
      flutter build ios --debug -v
      flutter build macos --debug -v
      flutter build web --debug -v
      flutter build appbundle --debug -v
    
    Rename project
      dart pub global activate rename
      dart pub global run rename --bundleId earth.limetrack.app
      dart pub global run rename --appname "Limetrack"
    
    Open project in XCode
      open ios/Runner.xcworkspace
      open macos/Runner.xcworkspace
    
    Rebuild launch icons
      flutter pub run icons_launcher:main
    
    Rebuild native splash screen
      flutter pub run flutter_native_splash:create

    Lines of code in project (run from lib folder)
      find . -name '*.dart' | xargs wc -l
  */
}
