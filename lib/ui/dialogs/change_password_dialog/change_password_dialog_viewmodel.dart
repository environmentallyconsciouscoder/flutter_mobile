import 'package:stacked/stacked.dart';

import 'package:limetrack/app/app.logger.dart';

import 'change_password_dialog.form.dart';

class ChangePasswordDialogViewModel extends FormViewModel {
  final log = getLogger('ChangePasswordDialogViewModel');

  bool _oldPasswordVisible = false;
  bool get oldPasswordVisible => _oldPasswordVisible;

  bool _newPasswordVisible = false;
  bool get newPasswordVisible => _newPasswordVisible;

  bool _retypePasswordVisible = false;
  bool get retypePasswordVisible => _retypePasswordVisible;

  void toggleOldPasswordVisible() {
    _oldPasswordVisible = !_oldPasswordVisible;
    notifyListeners();
  }

  void toggleNewPasswordVisible() {
    _newPasswordVisible = !_newPasswordVisible;
    notifyListeners();
  }

  void toggleRetypePasswordVisible() {
    _retypePasswordVisible = !_retypePasswordVisible;
    notifyListeners();
  }

  String? get getOldPasswordErrorText {
    if (oldPasswordValue != null && oldPasswordValue!.trim().isEmpty) {
      return 'required';
    }

    if (oldPasswordValue != null && oldPasswordValue!.trim().length < 7) {
      return 'too short';
    }

    // return null if the text is valid
    return null;
  }

  String? get getNewPasswordErrorText {
    if (newPasswordValue != null && newPasswordValue!.trim().isEmpty) {
      return 'required';
    }

    if (newPasswordValue != null && newPasswordValue!.trim().length < 7) {
      return 'too short';
    }

    // return null if the text is valid
    return null;
  }

  String? get getRetypePasswordErrorText {
    if (newPasswordValue != null && retypePasswordValue != null && (newPasswordValue!.trim() != retypePasswordValue!.trim())) {
      return 'passwords do not match';
    }

    // return null if the text is valid
    return null;
  }

  bool get isButtonEnabled {
    return (oldPasswordValue != null && oldPasswordValue!.trim().isNotEmpty && oldPasswordValue!.trim().length > 7) &&
        (newPasswordValue != null && newPasswordValue!.trim().isNotEmpty && newPasswordValue!.trim().length > 7) &&
        (newPasswordVisible ||
            (!newPasswordVisible &&
                newPasswordValue != null &&
                retypePasswordValue != null &&
                (newPasswordValue!.trim() == retypePasswordValue!.trim())));
  }

  @override
  void setFormStatus() {}
}
