import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/enums/basic_dialog_status.dart';
import 'package:limetrack/enums/dialog_type.dart';
import 'package:limetrack/enums/scan_mode.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/enums/site_type.dart';
import 'package:limetrack/models/bin.dart';
import 'package:limetrack/models/caddy.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/ui/common/app_strings.dart';

class ScanViewModel extends BaseViewModel {
  final log = getLogger('ScanViewModel');

  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final snackbarService = locator<SnackbarService>();
  final collectionService = locator<CollectionService>();

  // we can scan QR code in one of three modes:
  //   ScanMode.auto  - enable scanning and detect the type of QR presented (default)
  //   ScanMode.bin   - only scan for bin QR codes
  //   ScanMode.caddy - only scan for caddy QR code
  final ScanMode scanMode;

  // we need a CameraController to manage the torch state
  // and to toggle scanning between active and paused
  final CameraController cameraController = CameraController();

  CameraPosition _cameraPosition = CameraPosition.back;
  CameraPosition get cameraPosition => _cameraPosition;

  bool get torchState => cameraController.state.torchState;

  // set the default messages for ScanMode.auto
  String scanQrCodeMessage = ksScanQrCodeMessage;
  String qrCodeNotValidMessage = ksQrCodeNotValidMessage;
  String qrCodeNotRecognisedMessage = ksQrCodeNotRecognisedMessage;

  ScanViewModel({required this.scanMode});

  // we don't have a lot of initialisation to happen,
  // mostly we're just getting our environment ready
  Future<void> initialise() async {
    log.i('Initialising...');
    log.v('scanMode:$scanMode');

    initialiseMessages();

    log.v('Initialised');
  }

  // the ViewModel is set to dispose itself automatically
  // and when it does, we want to ensure that we correctly
  // dispose of the CameraController that we created
  @override
  Future<void> dispose() async {
    try {
      log.i('Disposing of CameraController');
      await cameraController.dispose();
      log.v('CameraController disposed');
    } catch (error) {
      log.e(error);
    }

    // make sure that we allow the rest of the ViewModel
    // to clean itself up
    super.dispose();
  }

  void initialiseMessages() {
    // if necessary, update the UI messages depending on
    // whether were scanning a bin or a caddy
    switch (scanMode) {
      case ScanMode.bin:
        scanQrCodeMessage = ksScanQrCodeMessageBin;
        qrCodeNotValidMessage = ksQrCodeNotValidMessageBin;
        qrCodeNotRecognisedMessage = ksQrCodeNotRecognisedMessageBin;
        break;
      case ScanMode.caddy:
        scanQrCodeMessage = ksScanQrCodeMessageCaddy;
        qrCodeNotValidMessage = ksQrCodeNotValidMessageCaddy;
        qrCodeNotRecognisedMessage = ksQrCodeNotRecognisedMessageCaddy;
        break;
      default:
    }

    notifyListeners();
  }

  void navigateBack() {
    navigationService.back();
  }

  Future<void> toggleCameraPosition() async {
    if (_cameraPosition == CameraPosition.back) {
      _cameraPosition = CameraPosition.front;
    } else {
      _cameraPosition = CameraPosition.back;
    }

    await cameraController.configure(position: _cameraPosition);
  }

  Future<void> toggleTorchState() async {
    await cameraController.toggleTorch();
    notifyListeners();
  }

  Future<void> pauseCamera() async {
    await cameraController.pauseCamera();
  }

  Future<void> resumeCamera() async {
    await cameraController.resumeCamera();
  }

  Future<void> enterQrCodeManually() async {
    // let's pause the camera so that we don't scan any
    // QR codes while we're manually entering the code
    await pauseCamera();

    DialogResponse? response = await dialogService.showCustomDialog(
      variant: DialogType.qrCodeEntry,
      title: 'Enter the QR code',
      mainButtonTitle: 'Continue',
      secondaryButtonTitle: 'Cancel',
    );

    if (response != null && response.confirmed) {
      // the user has given us a QR code so let's see what
      // we can do with it
      await processQrCode(response.data);
    } else {
      // the user has bailed from entering a QR code
      // so switch back to scanning for one
      await resumeCamera();
    }
  }

  Future<void> codeDetected(Barcode barCode) async {
    // this should be unnecessary because we're scanning in pauseVideo mode,
    // but let's make sure that we're not continuing to scan for QR codes
    await pauseCamera();

    // extract the QR code and pass it through for processing
    String? code = extractQrCodeFromUrl(barCode.value);

    // this is not a Limetrack code based on the QR code format
    if ((code != null && code.length < 5) || code == null) {
      await showRescanDialogOption(description: qrCodeNotValidMessage);
      return;
    }

    // this code is formatted like a Limetrack code so let's
    // see if it can processed
    await processQrCode(code);
  }

  String? extractQrCodeFromUrl(String url) {
    int codeStart = url.lastIndexOf('?id=');

    if (codeStart > 0) {
      String code = url.substring(codeStart + '?id='.length);

      // did we find a code?
      if (code.isNotEmpty) {
        return code;
      }
    }

    return null;
  }

  Future<void> processQrCode(String code) async {
    String codeType = code.substring(0, 1).toUpperCase();

    // before we process the QR code as either a bin or
    // a caddy code, we need to do some basic validation
    // that we have the code that we're expecting

    if (scanMode == ScanMode.bin && codeType != 'B') {
      // we are expecting to register a bin, but we have
      // a QR code that's likely to be a caddy code
      await showRescanDialogOption(description: ksExpectingBinCode);
      return;
    }

    if (scanMode == ScanMode.caddy && codeType == 'B') {
      // we are expecting to register a caddy, but we have
      // a QR code that's likely to be a bin code
      await showRescanDialogOption(description: ksExpectingCaddyCode);
      return;
    }

    // now we can attempt to process the code that we have
    // knowing that the code and action are what we expect

    if (codeType == 'B') {
      // if the QR code begins with 'B' then we know that
      // this is a bin code...
      await processBinQrCode(code);
    } else {
      // ...otherwise, for all other codes, assume that
      // they are caddy codes
      processCaddyQrCode(code);
    }
  }

  Future<void> processBinQrCode(String code) async {
    // lookup QR code and see if we have a bin in the database
    Bin? bin = await collectionService.getBinFromCode(code: code);

    // We cannot do anything with the bin code because
    // no bin exists in the database
    if (bin == null) {
      // QR code detected but is not one of ours
      await showRescanDialogOption(description: qrCodeNotRecognisedMessage);
      return;
    }

    log.i('Bin found:$bin');

    // the bin is not yet registered
    if (bin.siteId == null || (bin.siteId != null && bin.siteId!.isEmpty)) {
      log.v('Bin not registered');

      // can we register this bin? let's check if the user has
      // has registered sites that are allowed to host a bin
      if (collectionService.producerSites != null &&
          (collectionService.producerSites!.any((producerSite) =>
              producerSite.canHostBinShare == true || collectionService.producerSites!.any((element) => element.siteType == SiteType.hospitality)))) {
        log.v('At least one bin hub found');

        navigationService.clearTillFirstAndShow(
          Routes.registerBinView,
          arguments: RegisterBinViewArguments(bin: bin, scanMode: scanMode),
        );

        return;
      }

      log.e('No bin hubs found');

      // go back to the home view and alert the user that there are no bin hosts
      navigationService.clearStackAndShow(Routes.homeView);

      snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'SORRY',
        message: 'There are no available hubs to register this bin to. '
            'Please contact Limetrack to set this up for you.',
        duration: const Duration(seconds: 6),
      );

      return;
    }

    // if we've been asked to do a manual registration, and the
    // bin is already registered, then notify the user and return
    // to the dashboard
    if (scanMode == ScanMode.bin) {
      // go back to the home view and alert the user that there are no bin hosts
      navigationService.clearStackAndShow(Routes.homeView);

      snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'SORRY',
        message: 'This bin is already registered. To use it, simply scan the bin QR code.',
        duration: const Duration(seconds: 6),
      );

      return;
    }

    // if we get here, then we know this was an automatic scan,
    // we have a registered bin so we're good to go for recording
    // a deposit
    navigationService.clearTillFirstAndShow(
      Routes.enterDepositView,
      arguments: EnterDepositViewArguments(bin: bin),
    );
  }

  Future<void> processCaddyQrCode(String code) async {
    // lookup QR code and see if we have a caddy in the database
    Caddy? caddy = await collectionService.getCaddyFromCode(code: code);

    // We cannot do anything with the bin code because
    // no bin exists in the database
    if (caddy == null) {
      // QR code detected but is not one of ours
      await showRescanDialogOption(description: qrCodeNotRecognisedMessage);
      return;
    }

    log.i('Caddy found:$caddy');

    // the bin is not yet registered
    if (caddy.siteId == null || (caddy.siteId != null && caddy.siteId!.isEmpty)) {
      log.v('Caddy not registered');

      navigationService.clearTillFirstAndShow(
        Routes.registerCaddyView,
        arguments: RegisterCaddyViewArguments(caddy: caddy, scanMode: scanMode),
      );

      return;
    }

    // if we've been asked to do a manual registration, and the
    // caddy is already registered, then notify the user and return
    // to the dashboard
    if (scanMode == ScanMode.caddy) {
      // go back to the home view and alert the user that there are no bin hosts
      navigationService.clearStackAndShow(Routes.homeView);

      snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'SORRY',
        message: 'This caddy is already registered. To use it, simply scan the caddy QR code.',
        duration: const Duration(seconds: 6),
      );

      return;
    }

    // if we get here, then we know this was an automatic scan,
    // we have a registered caddy so we're good to go for recording
    // a deposit
    navigationService.clearTillFirstAndShow(
      Routes.enterWeightView,
      arguments: EnterWeightViewArguments(caddy: caddy),
    );
  }

  Future<void> showRescanDialogOption({required String description}) async {
    DialogResponse? response = await dialogService.showCustomDialog(
      variant: DialogType.basic,
      data: BasicDialogStatus.error,
      title: ksUnrecognisedQrCode,
      description: description,
      mainButtonTitle: ksRescan,
      secondaryButtonTitle: 'Dashboard',
    );

    if (response!.confirmed) {
      // the user would like to try again, so switch back to
      // scanning for a QR code
      await resumeCamera();
    } else {
      // user wants to return to the home screen
      await navigationService.clearStackAndShow(Routes.homeView);
    }
  }
}
