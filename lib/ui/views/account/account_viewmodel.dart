import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/models/address.dart';
import 'package:limetrack/models/producer.dart';
import 'package:limetrack/models/producer_site.dart';
import 'package:limetrack/models/producer_site_user.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/services/collection_service.dart';

class AccountViewModel extends BaseViewModel {
  final _log = getLogger('AccountViewModel');
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _databaseService = locator<DatabaseService>();
  final _collectionService = locator<CollectionService>();

  Producer? _producer;
  ProducerSite? _producerSite;
  Address? _address;

  String get userName => _collectionService.account!.name;
  String get userEmail => _collectionService.account!.email;

  String get siteName {
    if (_producer != null && _producerSite != null && _address != null) {
      if (_producerSite!.tradingAs != null && _producerSite!.tradingAs!.isNotEmpty) {
        return _producerSite!.tradingAs!;
      }

      if (_producer!.tradingAs != null && _producer!.tradingAs!.isNotEmpty) {
        return _producer!.tradingAs!;
      }

      if (_producer!.companyName.isNotEmpty) {
        return _producer!.companyName;
      }
    }

    return '';
  }

  String get addressLine1 {
    if (_address != null) {
      return _address!.line1;
    }

    return '';
  }

  bool get hasAddressLine2 => _address != null && _address!.line2 != null && _address!.line2!.isNotEmpty;

  String get addressLine2 {
    if (_address != null && _address!.line2 != null && _address!.line2!.isNotEmpty) {
      return _address!.line2!;
    }

    return '';
  }

  bool get hasAddressLine3 => _address != null && _address!.line3 != null && _address!.line3!.isNotEmpty;

  String get addressLine3 {
    if (_address != null && _address!.line3 != null && _address!.line3!.isNotEmpty) {
      return _address!.line3!;
    }

    return '';
  }

  bool get hasAddressTown => _address != null && _address!.town != null && _address!.town!.isNotEmpty;

  String get addressTown {
    if (_address != null && _address!.town != null && _address!.town!.isNotEmpty) {
      return _address!.town!;
    }

    return '';
  }

  String get addressPostcode {
    if (_address != null) {
      return _address!.postcode;
    }

    return '';
  }

  Future<void> initialise() async {
    _log.i('Initialising');

    try {
      _log.v('Getting producerSiteUser for [${_collectionService.account!.$id}]');

      // get the producerSite that the user is registered to
      List<ProducerSiteUser> producerSiteUsers = await _collectionService.listProducerSiteUsers(
        queries: [
          Query.equal('userId', _collectionService.account!.$id),
          Query.limit(100),
        ],
      );

      _log.v('Getting producerSite for [${producerSiteUsers.first.producerSiteId}]');

      // get the producerSite details
      List<ProducerSite> producerSites = await _collectionService.listProducerSites(
        queries: [
          Query.equal('\$id', producerSiteUsers.first.producerSiteId),
          Query.limit(100),
        ],
      );

      _producerSite = producerSites.first;

      _log.v('Getting producer for [${_producerSite!.$id}]');

      // get the producer details for the producerSite
      List<Producer> producers = await _collectionService.listProducers(
        queries: [
          Query.equal('\$id', _producerSite!.producerId),
          Query.limit(100),
        ],
      );

      _producer = producers.first;

      _log.v('Getting address for [${_producerSite!.$id}]');

      // get the address for the producerSite
      List<Address> addresses = await _collectionService.listAddresses(
        queries: [
          Query.equal('\$id', _producerSite!.siteAddressId),
          Query.limit(100),
        ],
      );

      _address = addresses.first;

      notifyListeners();

      _log.i('Initialised');
    } on AppwriteException catch (error) {
      _log.e(error.message);

      String errorMessage = _databaseService.friendlyErrorMessage(error.message);

      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'ERROR',
        message: errorMessage,
        duration: const Duration(seconds: 6),
      );
    } catch (error) {
      // log any other errors so that we can look into them
      _log.e(error);
    }
  }

  Future<void> foregroundBackgroundEvent(FGBGType value) async {
    _log.i(value);

    if (value == FGBGType.foreground) {
      _log.v('Refreshing dashboard');

      await _collectionService.refreshDashboardData();
      notifyListeners();

      _log.v('Dashboard refreshed');
    }
  }

  void navigateBack() {
    _navigationService.back();
  }

  void navigateToNotificationSettings() {
    _navigationService.navigateToAccountManagementNotificationsView();
  }

  void navigateToManageAccount() {
    _navigationService.navigateToAccountManagementView();
  }

  void navigateToManageTeam() {
    _navigationService.navigateToAccountManagementTeamView();
  }

  void navigateToManageBinsAndCaddies() {
    _navigationService.navigateToAccountManagementBinsAndCaddiesView();
  }

  void navigateToManageLiners() {
    _navigationService.navigateToAccountManagementLinersView();
  }

  Future<void> logoutUser() async {
    _log.i('Logging user out');
    try {
      // log the user out and then return to the login screen
      _databaseService.logout();

      _navigationService.clearStackAndShow(Routes.loginView);

      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnGreen,
        title: 'LOGGED OUT',
        message: 'You have been successfully logged out.',
        duration: const Duration(seconds: 4),
      );
      _log.v('User logged out');
    } on AppwriteException catch (error) {
      _log.e(error.message);

      String errorMessage = _databaseService.friendlyErrorMessage(error.message);

      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'ERROR',
        message: errorMessage,
        duration: const Duration(seconds: 6),
      );
    } catch (error) {
      // log any other errors so that we can look into them
      _log.e(error);
    }
  }
}
