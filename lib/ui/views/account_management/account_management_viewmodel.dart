import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/enums/dialog_type.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/services/database_service.dart';
// import 'package:limetrack/services/collection_service.dart';

class AccountManagementViewModel extends BaseViewModel {
  final _log = getLogger('AccountManagementViewModel');
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _snackbarService = locator<SnackbarService>();
  final _databaseService = locator<DatabaseService>();
  // final _collectionService = locator<CollectionService>();

  Future<void> initialise() async {
    _log.i('Initialising');

    _log.i('Initialised');
  }

  void navigateBack() {
    _navigationService.back();
  }

  Future<void> changePassword() async {
    _log.i('Changing user password');

    try {
      // let the user provide the details of the caddy they are registering
      DialogResponse? response = await _dialogService.showCustomDialog(
        variant: DialogType.changePassword,
        title: 'Change Password',
        description: 'Enter your current password and the new password you want to use.',
        mainButtonTitle: 'Change',
        secondaryButtonTitle: 'Cancel',
      );

      if (response!.confirmed) {
        _log.v('Changing password from ${response.data['oldPassword']} to ${response.data['newPassword']}');

        await _databaseService.updatePassword(
          newPassword: response.data['newPassword'],
          oldPassword: response.data['oldPassword'],
        );

        _snackbarService.showCustomSnackBar(
          variant: SnackbarType.whiteOnGreen,
          title: 'PASSWORD CHANGED',
          message: 'Your password was successfully changed.',
          duration: const Duration(seconds: 4),
        );

        _log.v('Password changed successfully.');
      }
    } on AppwriteException catch (error) {
      String errorMessage = _databaseService.friendlyErrorMessage(error.message);

      // in this particular case, we need to 'override' the friendly
      // error message because it means something slightly different
      if (error.message == 'Invalid credentials') {
        errorMessage = 'The password you entered as your current password does not match the one on record.';
      }

      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'ERROR',
        message: errorMessage,
        duration: const Duration(seconds: 6),
      );
    } catch (error) {
      // log any other errors so that we can look into them
      _log.e(error);
    }
  }
}
