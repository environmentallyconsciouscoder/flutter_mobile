import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/extensions/string_extensions.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/ui/base/authentication_viewmodel.dart';

import 'register_view.form.dart';

class RegisterViewModel extends AuthenticationViewModel {
  RegisterViewModel() : super(successRoute: Routes.producerRegistrationView);

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  String? get getNameErrorText {
    if (nameValue != null && nameValue!.trim().isEmpty) {
      return 'required';
    }

    // return null if the text is valid
    return null;
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

    if (passwordValue != null && passwordValue!.trim().length < 7) {
      return 'too short';
    }

    // return null if the text is valid
    return null;
  }

  bool get isContinueButtonEnabled {
    return (nameValue != null && nameValue!.trim().isNotEmpty) &&
        (emailValue != null &&
            emailValue!.trim().isNotEmpty &&
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(emailValue!)) &&
        (passwordValue != null && passwordValue!.trim().isNotEmpty && passwordValue!.trim().length > 7);
  }

  @override
  Future<AppwriteAuthResult> runAuthentication() => databaseService.registerWithEmail(
        name: nameValue!.trim().toTitleCase(),
        email: emailValue!.trim().toLowerCase(),
        password: passwordValue!.trim(),
      );

  void backTapped() => navigationService.back();
}
