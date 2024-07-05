import 'package:upgrader/upgrader.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/ui/base/authentication_viewmodel.dart';
import 'package:limetrack/services/upgrader_service.dart';

import 'login_view.form.dart';

class LoginViewModel extends AuthenticationViewModel {
  final upgraderService = locator<UpgraderService>();

  LoginViewModel({
    super.successRoute = Routes.homeView,
    super.alternateRoute = Routes.producerRegistrationView,
  });

  bool get isDeveloperEnvironment => upgraderService.isDevelopmentEnvironment;
  AppcastConfiguration get appcastConfig => upgraderService.appcastConfig;
  UpgraderMessages get customUpgraderMessages => upgraderService.customUpgraderMessages();

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  String? get getEmailErrorText {
    if (emailValue != null && emailValue!.trim().isEmpty) {
      return 'required';
    }

    if (emailValue != null && emailValue!.trim().isNotEmpty) {
      bool validEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(emailValue!);

      if (!validEmail) {
        return 'invalid email address';
      }
    }

    // return null if the text is valid
    return null;
  }

  String? get getPasswordErrorText {
    if (passwordValue != null && passwordValue!.trim().isEmpty) {
      return 'required';
    }

    // return null if the text is valid
    return null;
  }

  bool get isContinueButtonEnabled {
    return (emailValue != null &&
            emailValue!.trim().isNotEmpty &&
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(emailValue!)) &&
        (passwordValue != null && passwordValue!.trim().isNotEmpty);
  }

  @override
  void setFormStatus() {}

  @override
  Future<AppwriteAuthResult> runAuthentication() async {
    log.i('Signing in with email address $emailValue');
    AppwriteAuthResult appwriteAuthResult = await databaseService.signInWithEmail(
      email: emailValue!.trim(),
      password: passwordValue!.trim(),
    );

    if (appwriteAuthResult.account != null) {
      log.v('User ${appwriteAuthResult.account} found');

      // we need to call this here after successfully logging in because the startup
      // code will have already completed before the user logs in and key data won't
      // be set yet.
      collectionService.account = await databaseService.getCurrentAccount();
      collectionService.team = await databaseService.getAccountTeam();
      await collectionService.getProducerSitesForUser();
      await collectionService.recentActivity();
      await collectionService.getNearestBinShareAddress();
    }

    return appwriteAuthResult;
  }

  void forgotPassword() => navigationService.navigateTo(Routes.forgotPasswordView);
  void navigateToRegister() => navigationService.navigateTo(Routes.registerView);
}
