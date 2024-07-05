import 'package:stacked/stacked.dart';

import 'package:limetrack/app/app.logger.dart';

import 'add_user_to_team_dialog.form.dart';

class AddUserToTeamDialogViewModel extends FormViewModel {
  final log = getLogger('AddUserToTeamDialogViewModel');

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
      bool validEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(emailValue!.trim());

      if (!validEmail) {
        return 'invalid email address';
      }
    }

    // return null if the text is valid
    return null;
  }

  bool get isButtonEnabled {
    return (nameValue != null && nameValue!.trim().isNotEmpty) &&
        (emailValue != null &&
            emailValue!.trim().isNotEmpty &&
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(emailValue!.trim()));
  }

  @override
  void setFormStatus() {}

  Future<void> saveData() async {
    // log.i('Form values:$formValueMap');
    // log.i('siteType:$siteType');
    // log.i('role:$role');

    setBusy(true);

    setBusy(false);
  }
}
