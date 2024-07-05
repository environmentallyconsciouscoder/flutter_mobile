import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/enums/company_type.dart';
import 'package:limetrack/enums/simple_company_type.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/extensions/string_extensions.dart';
import 'package:limetrack/models/address.dart';
import 'package:limetrack/models/shared/contact.dart';
import 'package:limetrack/models/producer.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/services/database_service.dart';

import 'producer_registration_view.form.dart';

class ProducerRegistrationViewModel extends FormViewModel {
  final log = getLogger('ProducerRegistrationViewModel');

  final navigationService = locator<NavigationService>();
  final snackbarService = locator<SnackbarService>();
  final collectionService = locator<CollectionService>();
  final databaseService = locator<DatabaseService>();

  SimpleCompanyType? simpleCompanyType = SimpleCompanyType.registeredCompany;

  String? get getCompanyNameErrorText {
    if (companyNameValue != null && companyNameValue!.trim().isEmpty) {
      return 'required';
    }

    // return null if the text is valid
    return null;
  }

  String? get getCompanyNumberErrorText {
    if (companyNumberValue != null && companyNumberValue!.trim().isEmpty) {
      return 'required';
    }

    // return null if the text is valid
    return null;
  }

  String? get getAddressLine1ErrorText {
    if (addressLine1Value != null && addressLine1Value!.trim().isEmpty) {
      return 'required';
    }

    // return null if the text is valid
    return null;
  }

  String? get getAddressPostcodeErrorText {
    if (addressPostcodeValue != null && addressPostcodeValue!.trim().isEmpty) {
      return 'required';
    }

    // return null if the text is valid
    return null;
  }

  String? get getContactNameErrorText {
    if (contactNameValue != null && contactNameValue!.trim().isEmpty) {
      return 'required';
    }

    // return null if the text is valid
    return null;
  }

  String? get getContactEmailErrorText {
    if (contactEmailValue != null && contactEmailValue!.trim().isEmpty) {
      return 'required';
    }

    if (contactEmailValue != null && contactEmailValue!.trim().isNotEmpty) {
      bool validEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(contactEmailValue!);

      if (!validEmail) {
        return 'invalid email address';
      }
    }

    // return null if the text is valid
    return null;
  }

  String? get getContactMobileErrorText {
    if (contactMobileValue != null && contactMobileValue!.trim().isEmpty) {
      return 'required';
    }

    // return null if the text is valid
    return null;
  }

  bool get isContinueButtonEnabled {
    return (companyNameValue != null && companyNameValue!.trim().isNotEmpty) &&
        (simpleCompanyType != null &&
            ((simpleCompanyType == SimpleCompanyType.registeredCompany && companyNumberValue != null && companyNumberValue!.trim().isNotEmpty) ||
                (simpleCompanyType == SimpleCompanyType.soleTrader || simpleCompanyType == SimpleCompanyType.charity))) &&
        (simpleCompanyType != null) &&
        (addressLine1Value != null && addressLine1Value!.trim().isNotEmpty) &&
        (addressPostcodeValue != null && addressPostcodeValue!.trim().isNotEmpty) &&
        (contactNameValue != null && contactNameValue!.trim().isNotEmpty) &&
        (contactEmailValue != null &&
            contactEmailValue!.trim().isNotEmpty &&
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(contactEmailValue!)) &&
        (contactMobileValue != null && contactMobileValue!.isNotEmpty);
  }

  @override
  void setFormStatus() {}

  void simpleCompanyTypeOnChanged(String? value) {
    log.i('Value:$value');

    if (value != null) {
      simpleCompanyType = SimpleCompanyType.lookup(value);
      notifyListeners();
    }
  }

  Future<void> saveData() async {
    log.i('Form values:$formValueMap');
    log.i('simpleCompanyType:$simpleCompanyType');

    setBusy(true);

    // the logic for the 'uniqueness' for a team ID has has to change slightly
    // to accommodate sole traders who don't have a company registration number.
    String companyName = companyNameValue?.trim().toTitleCase() ?? '';
    String? companyNumber = companyNumberValue?.trim() ?? '';
    CompanyType? companyType;

    switch (simpleCompanyType) {
      case SimpleCompanyType.registeredCompany:
        companyType = CompanyType.limitedByShares;
        break;
      case SimpleCompanyType.soleTrader:
        companyType = CompanyType.soleTrader;
        companyNumber = null;
        break;
      case SimpleCompanyType.charity:
        companyType = CompanyType.charity;
        companyNumber = null;
        break;
      default:
        companyNumber = null;
    }

    // Cord schneider
    // cord.Schneider@Gmail.com
    // Password1234
    //
    // Memescape limited
    // Registered company
    // 12355935
    // memescape
    //
    // 71-75 shelton Street
    // lOndon
    // Wc2H 9Jq
    // cord Schneider
    // Cord.Schneider@gmail.COM
    // 07983591181

    try {
      // the account (user) should already be set on the previous
      // registerView but sometimes it seems to sometimes get
      // 'lost' when restarting the app while debugging
      collectionService.account = await databaseService.getCurrentAccount();
      collectionService.team = await databaseService.getAccountTeam();

      // if we don't find a team, we can assume that the producer
      // has not been registered, so let's create a new team
      if (!collectionService.hasTeam) {
        collectionService.team = await databaseService.teams.create(
          teamId: 'unique()',
          name: companyName,
        );
      }

      log.v('Team:${collectionService.team!.$id}');

      // when Appwrite creates a team, it automatically assigns the
      // user to the new team. We should only create a new team
      // membership if the team preexists and the user is not a member
      MembershipList membershipList = await databaseService.teams.listMemberships(
        teamId: collectionService.team!.$id,
        queries: [
          Query.limit(100),
        ],
      );

      bool found = false;
      if (membershipList.total > 0) {
        for (var membership in membershipList.memberships) {
          if (membership.userId == collectionService.account!.$id) {
            found = true;
            log.v('userId:${membership.userId} found in team:${collectionService.team!.$id}');
            break;
          }
        }
      }

      if (!found) {
        // now that we have a team, let's assign our new user to it
        Membership membership = await databaseService.teams.createMembership(
          teamId: collectionService.team!.$id,
          email: collectionService.account!.email.trim(),
          name: collectionService.account!.name.trim(),
          roles: [],
          url: databaseService.client.endPoint,
        );

        log.v('userId:${membership.userId} added to team:${collectionService.team!.$id}');
      }

      // Now that the user is assigned to a team, let's double-check that the
      // producer has not already been created. If not, we can create it
      List<Producer> producers = await collectionService.listProducers();

      Address producerAddress;
      Producer producer;

      if (producers.isEmpty) {
        // create the producer's address so that we have it for later
        producerAddress = await collectionService.createAddress(
          Address.instance(
            $id: 'unique()',
            $permissions: [
              Permission.read(Role.team(collectionService.team!.$id)),
              Permission.update(Role.team(collectionService.team!.$id)),
            ],
            line1: addressLine1Value?.trim().toTitleCase() ?? '',
            line2: addressLine2Value?.trim().toTitleCase(),
            line3: addressLine3Value?.trim().toTitleCase(),
            town: addressTownValue?.trim().toTitleCase(),
            postcode: addressPostcodeValue?.trim().toUpperCase() ?? '',
          ),
        );
        log.v('producerAddress:${producerAddress.$id}');

        // create the producer
        producer = await collectionService.createProducer(
          Producer.instance(
            $id: 'unique()',
            $permissions: [
              Permission.read(Role.team(collectionService.team!.$id)),
              Permission.update(Role.team(collectionService.team!.$id)),
            ],
            companyName: companyName,
            companyNumber: companyNumber,
            registeredAddressId: producerAddress.$id,
            companyType: companyType,
            tradingAs: tradingAsValue?.trim().toTitleCase() ?? '',
            contact: Contact(
              name: contactNameValue!.trim().toTitleCase(),
              email: contactEmailValue?.trim().toLowerCase(),
              phone: contactPhoneValue?.trim(),
              mobile: contactMobileValue?.trim(),
            ),
          ),
        );
      } else {
        // we should only have one producer returned so let's get it
        producer = producers.first;
        producerAddress = await collectionService.getAddress(producer.registeredAddressId);
      }
      log.v('producer:${producer.$id}');
      log.v('producerAddress:${producerAddress.$id}');

      // navigate to the next step of the registration process
      navigationService.replaceWith(
        Routes.producerSiteRegistrationView,
        arguments: ProducerSiteRegistrationViewArguments(
          producer: producer,
          producerAddress: producerAddress,
        ),
      );
    } on AppwriteException catch (error) {
      log.e(error.message);

      String errorMessage = databaseService.friendlyErrorMessage(error.message);

      snackbarService.showCustomSnackBar(
        variant: SnackbarType.whiteOnRed,
        title: 'ERROR',
        message: errorMessage,
        duration: const Duration(seconds: 6),
      );
    } catch (error) {
      // log any other errors so that we can look into them
      log.e(error);
    }

    setBusy(false);
  }
}
