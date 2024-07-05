import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/services/database_service.dart';

import 'forgot_password_view.form.dart';

class ForgotPasswordViewModel extends FormViewModel {
  final log = getLogger('ForgotPasswordViewModel');

  final navigationService = locator<NavigationService>();
  final databaseService = locator<DatabaseService>();

  String? get getEmailErrorText {
    if (emailValue != null && emailValue!.trim().isNotEmpty) {
      bool validEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(emailValue!);

      if (!validEmail) {
        return 'invalid email address';
      }
    }

    // return null if the text is valid
    return null;
  }

  bool get isResetButtonEnabled {
    return (emailValue != null &&
        emailValue!.trim().isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(emailValue!));
  }

  @override
  void setFormStatus() {
    // overridden so inherited classes don't have to implement it, but
    // inherited classes can implement it to provide realtime form validation
  }

  Future saveData() async {
    log.i('Form values:$formValueMap');

    try {} on AppwriteException catch (e) {
      log.e(e.toString());

      setValidationMessage(e.toString());
      notifyListeners();
    }
  }

  void backTapped() => navigationService.back();
}
