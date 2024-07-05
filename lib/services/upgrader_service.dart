import 'package:upgrader/upgrader.dart';
import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/services/environment_service.dart';

class UpgraderService {
  final log = getLogger('UpgraderService');
  final environmentService = locator<EnvironmentService>();

  bool _isDevelopmentEnvironment = false;
  bool get isDevelopmentEnvironment => _isDevelopmentEnvironment;

  bool _isVerboseLogging = false;
  bool get isVerboseLogging => _isVerboseLogging;

  late final AppcastConfiguration appcastConfig;

  Future<void> initialise() async {
    log.i('Initialising');

    _isDevelopmentEnvironment = environmentService.getValue('ENVIRONMENT').toLowerCase() == 'development';
    _isVerboseLogging = environmentService.getValue('APPCAST_VERBOSE_LOGGING', fallback: 'false').toLowerCase() == 'true';

    final String appcastURL = environmentService.getValue('APPCAST_URL', fallback: 'https://limetrack.earth/version/app_mobile/development.xml');

    if (_isDevelopmentEnvironment) {
      // Only call clearSavedSettings() during testing to reset internal values
      await Upgrader.clearSavedSettings();
    }

    appcastConfig = AppcastConfiguration(url: appcastURL, supportedOS: ['android', 'ios']);

    log.v('Initialised');
  }

  UpgraderMessages customUpgraderMessages() => CustomUpgraderMessages();
}

class CustomUpgraderMessages extends UpgraderMessages {
  @override
  String? message(UpgraderMessage messageKey) {
    if (languageCode == 'en') {
      switch (messageKey) {
        case UpgraderMessage.body:
          return '{{appName}} {{currentAppStoreVersion}} is available. You have {{currentInstalledVersion}} installed.';
        case UpgraderMessage.buttonTitleIgnore:
          return 'IGNORE';
        case UpgraderMessage.buttonTitleLater:
          return 'LATER';
        case UpgraderMessage.buttonTitleUpdate:
          return 'UPDATE NOW';
        case UpgraderMessage.prompt:
          return 'Would you like to update now?';
        case UpgraderMessage.releaseNotes:
          return 'Release Notes';
        case UpgraderMessage.title:
          return 'New Version!';
      }
    }
    // Messages that are not provided above can still use the default values.
    return super.message(messageKey);
  }
}
