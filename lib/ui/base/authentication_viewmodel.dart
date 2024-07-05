import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/services/database_service.dart';

abstract class AuthenticationViewModel extends FormViewModel {
  final log = getLogger('AuthenticationViewModel');

  final navigationService = locator<NavigationService>();
  final snackbarService = locator<SnackbarService>();
  final databaseService = locator<DatabaseService>();
  final collectionService = locator<CollectionService>();

  final String successRoute;
  final String? alternateRoute;

  AuthenticationViewModel({required this.successRoute, this.alternateRoute});

  @override
  void setFormStatus() {
    // overridden so inherited classes don't have to implement it, but
    // inherited classes can implement it to provide realtime form validation
  }

  Future<AppwriteAuthResult> runAuthentication();

  Future<void> saveData() async {
    log.i('Form values:$formValueMap');

    try {
      log.v('Authenticating');
      final result = await runBusyFuture(runAuthentication(), throwException: true);

      await _handleAuthenticationResponse(result);
    } on AppwriteException catch (e) {
      log.e(e.toString());

      setValidationMessage(e.toString());
      notifyListeners();
    }
  }

  Future<void> useAppleAuthentication() async {
    log.i('Authenticating with Apple SSO');

    final result = await databaseService.signInWithApple(
      appleClientId: '',
      appleRedirectUri: '',
    );

    await _handleAuthenticationResponse(result);
  }

  Future<void> useGoogleAuthentication() async {
    log.i('Authenticating with Google SSO');

    final result = await databaseService.signInWithGoogle();
    await _handleAuthenticationResponse(result);
  }

  Future<void> useFacebookAuthentication() async {
    log.i('Authenticating with Facebook SSO');

    final result = await databaseService.signInWithFacebook();
    await _handleAuthenticationResponse(result);
  }

  Future<void> useMicrosoftAuthentication() async {
    log.i('Authenticating with Microsoft SSO');

    final result = await databaseService.signInWithMicrosoft();
    await _handleAuthenticationResponse(result);
  }

  /// Checks if the result has an error. If it doesn't we navigate to the success view
  /// else we show the friendly validation message.
  Future<void> _handleAuthenticationResponse(AppwriteAuthResult authResult) async {
    log.v('authResult.hasError:${authResult.hasError}');

    if (!authResult.hasError && authResult.account != null) {
      // clear any ourstanding error messages
      setValidationMessage('');
      notifyListeners();

      // persist the logged in user and check if they're assigned to a team
      collectionService.account = authResult.account;
      collectionService.team = await databaseService.getAccountTeam();

      if (!collectionService.hasTeam && alternateRoute != null) {
        // navigate to alternate route
        navigationService.clearStackAndShow(alternateRoute!);
      } else {
        // navigate to success route
        navigationService.clearStackAndShow(successRoute);
      }
    } else {
      if (!authResult.hasError && authResult.account == null) {
        log.wtf('We have no error but the user is null. This should never happen!');
      }

      log.w('Authentication Failed: ${authResult.errorMessage}');

      snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'ERROR',
        message: authResult.errorMessage ?? '',
        duration: const Duration(seconds: 6),
      );
    }
  }
}
