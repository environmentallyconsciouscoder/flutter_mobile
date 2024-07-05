import 'package:flutter/material.dart';

import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/enums/dialog_type.dart';
import 'package:limetrack/ui/dialogs/add_user_to_team_dialog/add_user_to_team_dialog.dart';
import 'package:limetrack/ui/dialogs/basic_dialog/basic_dialog.dart';
import 'package:limetrack/ui/dialogs/change_password_dialog/change_password_dialog.dart';
import 'package:limetrack/ui/dialogs/info_dialog/info_dialog.dart';
import 'package:limetrack/ui/dialogs/qr_code_entry_dialog/qr_code_entry_dialog.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (BuildContext context, DialogRequest request, Function(DialogResponse) completer) =>
        BasicDialog(request: request, completer: completer),
    DialogType.info: (BuildContext context, DialogRequest request, Function(DialogResponse) completer) =>
        InfoDialog(request: request, completer: completer),
    DialogType.qrCodeEntry: (BuildContext context, DialogRequest request, Function(DialogResponse) completer) =>
        QrCodeEntryDialog(request: request, completer: completer),
    DialogType.addUserToTeam: (BuildContext context, DialogRequest request, Function(DialogResponse) completer) =>
        AddUserToTeamDialog(request: request, completer: completer),
    DialogType.changePassword: (BuildContext context, DialogRequest request, Function(DialogResponse) completer) =>
        ChangePasswordDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
