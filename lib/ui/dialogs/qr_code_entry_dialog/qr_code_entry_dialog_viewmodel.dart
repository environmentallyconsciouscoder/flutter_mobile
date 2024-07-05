import 'package:stacked/stacked.dart';

import 'package:limetrack/app/app.logger.dart';

import 'qr_code_entry_dialog.form.dart';

class QrCodeEntryDialogViewModel extends FormViewModel {
  final log = getLogger('QrCodeEntryDialogViewModel');

  String? get getCodeErrorText {
    if (codeValue != null && codeValue!.trim().isEmpty) {
      return 'required';
    }

    if (codeValue != null && codeValue!.trim().length != 5) {
      return 'qr code must be 5 characters';
    }

    // return null if the text is valid
    return null;
  }

  bool get isButtonEnabled {
    return (codeValue != null && codeValue!.trim().isNotEmpty && codeValue!.trim().length == 5);
  }

  @override
  void setFormStatus() {}
}
