import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/enums/dialog_type.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/services/collection_service.dart';

class AccountManagementTeamViewModel extends BaseViewModel {
  final _log = getLogger('AccountManagementTeamViewModel');
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _snackbarService = locator<SnackbarService>();
  final _databaseService = locator<DatabaseService>();
  final _collectionService = locator<CollectionService>();

  List<Membership> membershipList = [];
  bool _isTeamOwner = false;
  bool get isTeamOwner => _isTeamOwner;

  Future<void> initialise() async {
    _log.i('Initialising');

    try {
      // get team membership
      membershipList = await _databaseService.getTeamList(teamId: _collectionService.team!.$id);
      Membership? currentMembership;

      for (Membership membership in membershipList) {
        if (membership.userId == _collectionService.account!.$id) {
          currentMembership = membership;
          _isTeamOwner = membership.roles.contains('owner');
        }
      }

      // we don't want to display the current user in the
      // membershipList
      if (currentMembership != null) {
        membershipList.remove(currentMembership);
      }

      notifyListeners();

      _log.i('Initialised');
    } on AppwriteException catch (error) {
      _log.e(error.message);

      String errorMessage = _databaseService.friendlyErrorMessage(error.message);

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

  void navigateBack() {
    _navigationService.back();
  }

  Future<void> removeFromTeam({required Membership membership}) async {
    _log.i('Removing user from team');

    setBusy(true);

    try {
      // let the user provide the details of the caddy they are registering
      DialogResponse? response = await _dialogService.showCustomDialog(
        variant: DialogType.basic,
        title: 'Remove from Team',
        description: 'Are you sure that you want to remove ${membership.userName} from your team?',
        mainButtonTitle: 'Remove',
        secondaryButtonTitle: 'Cancel',
      );

      if (response!.confirmed) {
        await _databaseService.removeFromTeam(teamId: membership.teamId, membershipId: membership.$id);
        membershipList.remove(membership);

        _log.v('User removed from team.');
      }
    } on AppwriteException catch (error) {
      String errorMessage = _databaseService.friendlyErrorMessage(error.message);

      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'ERROR',
        message: errorMessage,
        duration: const Duration(seconds: 6),
      );
    } catch (error) {
      // log any other errors so that we can look into them
      _log.e(error);
    } finally {
      setBusy(false);
    }
  }

  Future<void> addToTeam() async {
    _log.i('Adding user to team');

    setBusy(true);

    try {
      // let the user provide the details of the caddy they are registering
      DialogResponse? response = await _dialogService.showCustomDialog(
        variant: DialogType.addUserToTeam,
        title: 'Add to Team',
        description: 'Enter the name and email of the person you want to add to your team.',
        mainButtonTitle: 'Add User',
        secondaryButtonTitle: 'Cancel',
      );

      if (response!.confirmed) {
        _log.v('Add user to team response:${response.data}');

        await _databaseService.addToTeam(
          ownerId: _collectionService.account!.$id,
          teamId: _collectionService.team!.$id,
          name: response.data['name'],
          email: response.data['email'],
          producerSiteId: _collectionService.producerSites!.first.$id,
        );

        _snackbarService.showCustomSnackBar(
          variant: SnackbarType.whiteOnGreen,
          title: 'ADD TO TEAM',
          message: 'Invitation to join team sent to ${response.data['name']}.',
          duration: const Duration(seconds: 4),
        );

        _log.v('Request to add user to team completed.');

        // refresh the user list
        await initialise();
      }
    } on AppwriteException catch (error) {
      String errorMessage = _databaseService.friendlyErrorMessage(error.message);

      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'ERROR',
        message: errorMessage,
        duration: const Duration(seconds: 6),
      );
    } catch (error) {
      // log any other errors so that we can look into them
      _log.e(error);
    } finally {
      setBusy(false);
    }
  }
}
