import 'dart:async';

import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:upgrader/upgrader.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/enums/dialog_type.dart';
import 'package:limetrack/enums/site_type.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/services/upgrader_service.dart';
import 'package:limetrack/ui/views/reports/reports_view.dart';
import 'package:limetrack/ui/views/scan/scan_view.dart';
import 'package:limetrack/ui/views/transfer_details/transfer_details_view.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final databaseService = locator<DatabaseService>();
  final collectionService = locator<CollectionService>();
  final upgraderService = locator<UpgraderService>();

  bool get isDeveloperEnvironment => upgraderService.isDevelopmentEnvironment;
  bool get isVerboseLogging => upgraderService.isVerboseLogging;

  late final Timer refreshTimer;

  AppcastConfiguration get appcastConfig => upgraderService.appcastConfig;
  UpgraderMessages get customUpgraderMessages => upgraderService.customUpgraderMessages();

  String get userGreeting {
    final int hour = DateTime.now().hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return '$greeting, ${collectionService.account!.name.split(' ').first.trim()}!';
  }

  String get siteName {
    if (collectionService.producerSites != null && collectionService.producerSites!.isNotEmpty) {
      if (collectionService.producerSites!.first.tradingAs != null && collectionService.producerSites!.first.tradingAs!.isNotEmpty) {
        return collectionService.producerSites!.first.tradingAs!;
      }
    }

    if (collectionService.producers != null && collectionService.producers!.isNotEmpty) {
      if (collectionService.producers!.first.tradingAs != null && collectionService.producers!.first.tradingAs!.isNotEmpty) {
        return collectionService.producers!.first.tradingAs!;
      } else {
        return collectionService.producers!.first.companyName;
      }
    }

    return '';
  }

  String get totalWeighed {
    double weightInKgs = collectionService.totalWeighed / 1000;
    return '${weightInKgs.toStringAsFixed(1)}kg';
  }

  String get co2Equivalent {
    //const double co2eFactor = 2.538461538461538;
    const double co2eFactor = 2.543795454545455;
    double weightInKgs = collectionService.totalWeighed / 1000;
    double co2eInKgs = weightInKgs * co2eFactor;

    return '${co2eInKgs.toStringAsFixed(1)}kg';
  }

  String get lastWeighedWeight {
    if (collectionService.lastWeighed != null && collectionService.lastWeighed!.weight != null) {
      return '${(collectionService.lastWeighed!.weight! / 1000).toStringAsFixed(1)}kg weighed';
    } else {
      return "You haven't weighed anything recently";
    }
  }

  String get lastWeighedDate {
    if (collectionService.lastWeighed != null) {
      return DateFormat("d MMM 'at' HH:mm").format(collectionService.lastWeighed!.timestamp.toLocal());
    } else {
      return '';
    }
  }

  String get lastDepositedWeight {
    if (collectionService.lastDeposited != null && collectionService.lastDeposited!.weight != null) {
      return '${(collectionService.lastDeposited!.weight! / 1000).toStringAsFixed(1)}kg deposited';
    } else {
      return "You haven't deposited anything recently";
    }
  }

  bool get depositInferred {
    if (collectionService.lastDeposited != null) {
      return collectionService.lastDeposited!.inferred!;
    }

    return false;
  }

  String get lastDepositedDate {
    if (collectionService.lastDeposited != null) {
      if (collectionService.lastDeposited!.inferred!) {
        return '${DateFormat("d MMM").format(collectionService.lastDeposited!.timestamp.toLocal())} (deposit inferred)';
      } else {
        return DateFormat("d MMM 'at' HH:mm").format(collectionService.lastDeposited!.timestamp.toLocal());
      }
    } else {
      return '';
    }
  }

  String get totalCollectedWeight {
    if (collectionService.lastCollected != null) {
      return '${(collectionService.totalCollectedWeight / 1000).toStringAsFixed(1)}kg collected';
    } else {
      return 'Nothing has been collected recently';
    }
  }

  String get lastCollectedDate {
    if (collectionService.lastCollected != null) {
      return DateFormat("d MMM 'at' HH:mm").format(collectionService.lastCollected!.timestamp.toLocal());
    } else {
      return '';
    }
  }

  bool get isNonHospitality {
    // again, we're making assumptions for now that there is only one ProducerSite
    // linked to this user. Later, we will need to account for multiple sites
    return collectionService.producerSites!.first.siteType == SiteType.nonHospitality;
  }

  String get nearestBinShareAddress {
    if (collectionService.nearestBinShareAddress != null) {
      return '${collectionService.nearestBinShareAddress!.line1}, ${collectionService.nearestBinShareAddress!.postcode}';
    }

    return 'None found';
  }

  Future<void> initialise() async {
    log.i('Initialising...');

    refreshTimer = Timer.periodic(const Duration(seconds: 150), (timer) async {
      log.i('Refreshing dashboard');
      await collectionService.refreshDashboardData();
      log.v('Dashboard refreshed');

      notifyListeners();
    });

    log.i('Initialised');
  }

  @override
  Future<void> dispose() async {
    log.i('Cancelling refreshTimer...');
    refreshTimer.cancel();
    log.v('refreshTimer cancelled');

    // make sure that we allow the rest of the ViewModel
    // to clean itself up
    super.dispose();
  }

  Future<void> foregroundBackgroundEvent(FGBGType value) async {
    log.i(value);

    if (value == FGBGType.foreground) {
      log.v('Refreshing dashboard');
      await collectionService.refreshDashboardData();
      log.v('Dashboard refreshed');

      notifyListeners();
    }
  }

  Future<void> cO2EquivalentInfo() async {
    await dialogService.showCustomDialog(
      variant: DialogType.info,
      title: 'CO\u2082 equivalent',
      description: 'There is no simple way of calculating the impact of food waste on GHG emissions, nor is '
          'there a straightforward way of estimating the carbon footprint of food in general. This makes '
          'calculating CO\u2082e savings hard.\n\n'
          'We use research conducted by the Food & Agriculture Organization of the United Nations (FAO) from '
          '2013 that estimates 1kg of food waste equals ~2.5kg of CO\u2082e.',
    );
  }

  Future<void> depositEstimateInfo() async {
    await dialogService.showCustomDialog(
      variant: DialogType.info,
      title: 'Deposit inferred',
      description: 'Recording your food waste deposits into your local bin share is currently an optional '
          'step. So to avoid cluttering up your screen with undeposited food waste recordings, we will assume '
          'that after 2 hours, you have dropped your food waste off into your local bin share.',
    );
  }

  Future<void> nearestLocationInfo() async {
    await dialogService.showCustomDialog(
      variant: DialogType.info,
      title: 'Nearest bin share',
      description: 'This is the location of your nearest bin share where you will deposit your weighed food '
          'waste.\n\n'
          'If you have not been allocated a bin share, please contact Limetrack so that we can sort that out.',
    );
  }

  void onShareWithUser() async {
    log.i('Sharing Limetrack with new user...');

    String shareText = "I've been using Limetrack to help reduce my food waste and me save money. "
        "Why don't you join me?\n\nVisit https://limetrack.earth for more information.";

    String shareSubject = 'Join Limetrack and start saving!';

    ShareResult result = await Share.shareWithResult(shareText, subject: shareSubject);
    log.v('Sharing result:${result.status}');
  }

  Future<void> navigateToTransferDetailView() async {
    navigationService.navigateWithTransition(const TransferDetailsView(), transitionStyle: Transition.downToUp);
  }

  void navigateToReportsView() {
    navigationService.navigateWithTransition(const ReportsView(), transitionStyle: Transition.leftToRight);
  }

  void navigateToScanView() {
    navigationService.navigateWithTransition(const ScanView(), transitionStyle: Transition.zoom);
  }

  void navigateToAccountView() {
    navigationService.navigateTo(Routes.accountView);
  }
}
