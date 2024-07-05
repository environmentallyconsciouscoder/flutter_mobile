import 'dart:convert';
import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/services/environment_service.dart';

class DatabaseService {
  final log = getLogger('DatabaseService');
  final environmentService = locator<EnvironmentService>();

  final Client client = Client();
  late final Account accounts;
  late final Teams teams;
  late final Databases databases;
  late final Storage storage;
  late final Functions functions;
  late final Locale locale;

  DatabaseService() {
    // create API access points
    log.i('Creating Appwrite API access points');
    accounts = Account(client);
    teams = Teams(client);
    databases = Databases(client);
    storage = Storage(client);
    functions = Functions(client);
    locale = Locale(client);
    log.v('Appwrite API access points created');
  }

  void initialise() {
    log.i('Initialising');

    String endPoint = environmentService.getValue('ENDPOINT');
    String projectId = environmentService.getValue('PROJECT_ID');

    // change the endPoint to work with Android emulator
    if (Platform.isAndroid && endPoint.contains('localhost')) {
      log.i('Fix endPoint to work with Android emulator');
      endPoint = endPoint.replaceAll('localhost', '10.0.2.2');
      log.v('endPoint:$endPoint');
    }

    log.i('Creating Appwrite main entrypoint');

    // set the Appwrite endpoint and project to use
    client.setEndpoint(endPoint).setProject(projectId);

    // if we're not connecting over SSL
    if (endPoint.toLowerCase().contains('http://')) {
      client.setSelfSigned();
    }

    log.v('Initialised');
  }

  String friendlyErrorMessage(
    String? errorMessage,
  ) {
    String friendlyErrorMessage;

    switch (errorMessage) {
      case 'Param "email" is not optional.':
        friendlyErrorMessage = 'Please enter an email address and try again.';
        break;
      case 'Param "password" is not optional.':
        friendlyErrorMessage = 'Please enter a password and try again.';
        break;
      case 'Invalid email: Value must be a valid email address':
        friendlyErrorMessage = 'The email address that you entered is not valid.';
        break;
      case 'Invalid password: Password must be at least 8 characters':
        friendlyErrorMessage = 'The password that you entered must be at least 8 characters.';
        break;
      case 'Invalid credentials':
        friendlyErrorMessage = 'The email address and password combination is incorrect.';
        break;
      case 'Account already exists':
        friendlyErrorMessage = 'Unable to register a new account as an account with this email address already exists.';
        break;
      case "No permissions provided for action 'execute'":
        friendlyErrorMessage = 'Your account does not have permission to perform that action.';
        break;
      default:
        // handle other error messages that are not constant strings
        if (errorMessage?.contains('SocketException: Connection refused') ?? false) {
          friendlyErrorMessage = 'The server is not currently available. Please try again later.';
        } else {
          friendlyErrorMessage = errorMessage ?? 'An unknown error occurred.';
        }
    }

    return friendlyErrorMessage;
  }

  Future<models.Account?> getCurrentAccount() async {
    try {
      log.i('Getting logged in account');
      models.Account account = await accounts.get();

      if (account.email.isNotEmpty) {
        log.v('Account found:${account.email}');
        return account;
      } else {
        log.wtf('Account found, but no valid email. Likely caused by an incomplete registration.');
      }
    } on AppwriteException catch (error) {
      log.e(error.message);
    }

    return null;
  }

  Future<models.Preferences?> getAccountPreferences() async {
    try {
      log.i('Getting account preferences');
      models.Preferences preferences = await accounts.getPrefs();
      log.v('Preferences found:$preferences');

      return preferences;
    } on AppwriteException catch (error) {
      log.e(error.message);
    }

    return null;
  }

  Future<models.Team?> getAccountTeam() async {
    try {
      log.i('Getting account\'s team');
      models.TeamList teamList = await teams.list();

      if (teamList.total > 0) {
        log.v('Team found:${teamList.toMap()}');
        return teamList.teams.first;
      }
    } on AppwriteException catch (error) {
      log.e(error.message);
    }

    log.v('No team found');
    return null;
  }

  Future<AppwriteAuthResult> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    final String errorMessage;

    try {
      log.i('Registering account with email');
      final models.Account account = await accounts.create(
        userId: 'unique()',
        email: email,
        password: password,
        name: name,
      );
      log.v('Account:$account');

      log.i('Creating a session for the account');
      final models.Session session = await accounts.createEmailSession(
        email: email,
        password: password,
      );
      log.v('Session:$session');

      return AppwriteAuthResult(account: account);
    } on AppwriteException catch (error) {
      errorMessage = friendlyErrorMessage(error.message);
      log.e(error.message);
    }

    return AppwriteAuthResult.error(errorMessage: errorMessage);
  }

  Future<AppwriteAuthResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final String errorMessage;

    try {
      log.i('Signing account in with email');
      final models.Session session = await accounts.createEmailSession(
        email: email,
        password: password,
      );
      log.v('Session:$session');

      final models.Account account = await accounts.get();
      log.v('Account:$account');

      return AppwriteAuthResult(account: account);
    } on AppwriteException catch (error) {
      errorMessage = friendlyErrorMessage(error.message);
      log.e(error.message);
    }

    return AppwriteAuthResult.error(errorMessage: errorMessage);
  }

  // TODO:
  // Apple single sign-on (SSO)
  Future<AppwriteAuthResult> signInWithApple({
    required String? appleClientId,
    required String? appleRedirectUri,
  }) async {
    return AppwriteAuthResult.error(errorMessage: 'Apple SSO not implemented');
  }

  // TODO:
  // Google single sign-on (SSO)
  Future<AppwriteAuthResult> signInWithGoogle() async {
    return AppwriteAuthResult.error(errorMessage: 'Google SSO not implemented');
  }

  // TODO:
  // Facebook single sign-on (SSO)
  Future<AppwriteAuthResult> signInWithFacebook() async {
    return AppwriteAuthResult.error(errorMessage: 'Facebook SSO not implemented');
  }

  // TODO:
  // Microsoft single sign-on (SSO)
  Future<AppwriteAuthResult> signInWithMicrosoft() async {
    return AppwriteAuthResult.error(errorMessage: 'Microsoft SSO not implemented');
  }

  Future<void> signInWithMagicUrl({
    required String accountId,
    required String email,
    String url = '',
  }) async {
    try {
      log.i('Signing in with Magic Url');
      models.Token token = await accounts.createMagicURLSession(
        userId: accountId,
        email: email,
        url: url,
      );
      log.v('Magic Url created:$token');
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  Future<AppwriteAuthResult> magicUrlConfirmation({
    required String accountId,
    required String secret,
  }) async {
    final String errorMessage;

    try {
      log.i('Magic Url confirmation');
      models.Session session = await accounts.updateMagicURLSession(
        userId: accountId,
        secret: secret,
      );
      log.v('Session:$session');

      final models.Account account = await accounts.get();
      log.v('Account:$account');

      return AppwriteAuthResult(account: account);
    } on AppwriteException catch (error) {
      errorMessage = friendlyErrorMessage(error.message);
      log.e(error.message);
    }

    return AppwriteAuthResult.error(errorMessage: errorMessage);
  }

  Future<models.Account?> updateAccountName({
    required String name,
  }) async {
    try {
      log.i('Updating account name');
      models.Account account = await accounts.updateName(
        name: name,
      );
      log.v('Account name updated:$account');

      return account;
    } on AppwriteException catch (error) {
      log.e(error.message);
    }

    return null;
  }

  Future<models.Account> updatePassword({
    required String newPassword,
    String? oldPassword,
  }) async {
    log.i('Updating account password');

    models.Account account = await accounts.updatePassword(
      password: newPassword,
      oldPassword: oldPassword,
    );

    log.v('Password updated:$account');

    return account;
  }

  Future<models.Account?> updateEmail({
    required String email,
    required String password,
  }) async {
    try {
      log.i('Updating account email');
      models.Account account = await accounts.updateEmail(
        email: email,
        password: password,
      );
      log.v('Email updated:$account');

      return account;
    } on AppwriteException catch (error) {
      log.e(error.message);
    }

    return null;
  }

  Future<models.Account?> updateAccountPreferences({
    required Map<dynamic, dynamic> preferences,
  }) async {
    try {
      log.i('Updating account preferences');
      models.Account account = await accounts.updatePrefs(
        prefs: preferences,
      );
      log.v('Preferences updated:$account');

      return account;
    } on AppwriteException catch (error) {
      log.e(error.message);
    }

    return null;
  }

  Future<void> blockAccount() async {
    try {
      log.i('Blocking account');
      await accounts.updateStatus();
      log.v('Account blocked');
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  Future<void> logout({
    String sessionId = 'current',
  }) async {
    try {
      log.i('Logging account out');
      await accounts.deleteSession(
        sessionId: sessionId,
      );
      log.v('Account logged out');
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  Future<AppwriteAuthResult> updateSession({
    String sessionId = 'current',
  }) async {
    final String errorMessage;

    try {
      log.i('Refreshing account session');
      final models.Session session = await accounts.updateSession(
        sessionId: sessionId,
      );
      log.v('Session:$session');

      // refresh account details
      final models.Account account = await accounts.get();
      log.v('Account:$account');

      return AppwriteAuthResult(account: account);
    } on AppwriteException catch (error) {
      errorMessage = friendlyErrorMessage(error.message);
      log.e(error.message);
    }

    return AppwriteAuthResult.error(errorMessage: errorMessage);
  }

  Future<void> deleteSessions() async {
    try {
      log.i('Deleting account session');
      await accounts.deleteSessions();

      log.v('Account session deleted');
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  Future<void> recoverPassword({
    required String email,
    required String url,
  }) async {
    try {
      log.i('Recovering account password');
      final models.Token token = await accounts.createRecovery(
        email: email,
        url: url,
      );
      log.v('Token:$token');
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  Future<void> recoverPasswordConfirmation({
    required String accountId,
    required String secret,
    required String password,
    required String passwordAgain,
  }) async {
    try {
      log.i('Confirming account\'s password recovery');
      final models.Token token = await accounts.updateRecovery(
        userId: accountId,
        secret: secret,
        password: password,
        passwordAgain: passwordAgain,
      );
      log.v('Token:$token');
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  Future<void> verifyEmail({
    required String url,
  }) async {
    try {
      log.i('Verifying account email');
      final models.Token token = await accounts.createVerification(
        url: url,
      );
      log.v('Token:$token');
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  Future<void> verifyEmailConfirmation({
    required String accountId,
    required String secret,
  }) async {
    try {
      log.i('Confirming account\'s email verification');
      final models.Token token = await accounts.updateVerification(
        userId: accountId,
        secret: secret,
      );
      log.v('Token:$token');
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  Future<List<models.Membership>> getTeamList({
    required String teamId,
  }) async {
    List<models.Membership> results = [];
    models.MembershipList membershipList;
    String? cursor;

    log.i('Fetching membership list for [$teamId]');

    do {
      membershipList = await teams.listMemberships(
        teamId: teamId,
        queries: [
          if (cursor != null) Query.cursorAfter(cursor),
          Query.limit(100),
        ],
      );

      if (membershipList.memberships.isNotEmpty) {
        log.v('Adding ${membershipList.memberships.length} elements to membership list');

        results.addAll(membershipList.memberships);
        cursor = membershipList.memberships[membershipList.memberships.length - 1].$id;
      }
    } while (membershipList.memberships.length >= 100);

    log.v('Membership list fetched. ${results.length} memberships located.');
    return results;
  }

  Future<void> removeFromTeam({required String teamId, required String membershipId}) async {
    try {
      log.i('Removing membership:$membershipId from team:$teamId');

      await teams.deleteMembership(teamId: teamId, membershipId: membershipId);

      log.v('Membership removed');
    } on AppwriteException catch (error) {
      log.e(error.message);
      rethrow;
    }
  }

  Future<void> addToTeam({
    required String ownerId,
    required String teamId,
    required String name,
    required String email,
    required String producerSiteId,
  }) async {
    try {
      log.i('Adding account:$name to team:$teamId');

      final models.Execution execution = await functions.createExecution(
        functionId: 'AddToTeam',
        data: jsonEncode({
          'ownerId': ownerId,
          'teamId': teamId,
          'name': name,
          'email': email,
          'producerSiteId': producerSiteId,
        }),
      );

      log.v('Account added: $execution');
    } on AppwriteException catch (error) {
      log.e(error.message);
      rethrow;
    }
  }
}

class AppwriteAuthResult {
  /// Appwrite account
  final models.Account? account;

  /// Contains the error message for the request
  final String? errorMessage;

  AppwriteAuthResult({this.account}) : errorMessage = null;

  AppwriteAuthResult.error({this.errorMessage}) : account = null;

  /// Returns true if the response has an error associated with it
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
