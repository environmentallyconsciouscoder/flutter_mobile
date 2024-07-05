import 'package:appwrite/appwrite.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/enums/site_type.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/enums/user_role.dart';
import 'package:limetrack/extensions/string_extensions.dart';
import 'package:limetrack/models/address.dart';
import 'package:limetrack/models/producer_site.dart';
import 'package:limetrack/models/producer_site_user.dart';
import 'package:limetrack/models/shared/contact.dart';
import 'package:limetrack/models/producer.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/services/database_service.dart';

import 'producer_site_registration_view.form.dart';

class ProducerSiteRegistrationViewModel extends FormViewModel {
  final log = getLogger('ProducerSiteRegistrationViewModel');

  final navigationService = locator<NavigationService>();
  final snackbarService = locator<SnackbarService>();
  final collectionService = locator<CollectionService>();
  final databaseService = locator<DatabaseService>();

  bool useSameAddressAsProducer = false;
  bool useSameContactAsProducer = true;
  SiteType? siteType;
  UserRole? userRole;

  late final Producer producer;
  late final Address producerAddress;
  Address? producerSiteAddress;
  ProducerSite? producerSite;
  ProducerSiteUser? producerSiteUser;

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

  bool get isFinishButtonEnabled {
    return (addressLine1Value != null && addressLine1Value!.trim().isNotEmpty) &&
        (addressPostcodeValue != null && addressPostcodeValue!.trim().isNotEmpty) &&
        (contactNameValue != null && contactNameValue!.trim().isNotEmpty) &&
        (contactEmailValue != null &&
            contactEmailValue!.trim().isNotEmpty &&
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(contactEmailValue!)) &&
        (contactMobileValue != null && contactMobileValue!.trim().isNotEmpty) &&
        (siteType != null) &&
        (userRole != null);
  }

  @override
  void setFormStatus() {}

  void setArguments(Producer producer, Address producerAddress) {
    this.producer = producer;
    this.producerAddress = producerAddress;
  }

  void addressSameAsProducerOnChanged(bool? value) {
    log.i('Value:$value');

    useSameAddressAsProducer = value!;
    notifyListeners();
  }

  void addressSameAsProducerOnTap() {
    addressSameAsProducerOnChanged(!useSameAddressAsProducer);
  }

  void contactSameAsProducerOnChanged(bool? value) {
    log.i('Value:$value');

    useSameContactAsProducer = value!;
    notifyListeners();
  }

  void contactSameAsProducerOnTap() {
    contactSameAsProducerOnChanged(!useSameContactAsProducer);
  }

  void siteTypeOnChanged(String? value) {
    log.i('Value:$value');

    if (value != null) {
      siteType = SiteType.lookup(value);
      notifyListeners();
    }
  }

  void userRoleOnChanged(String? value) {
    log.i('Value:$value');

    if (value != null) {
      userRole = UserRole.lookup(value);
      notifyListeners();
    }
  }

  Future<void> saveData() async {
    log.i('Form values:$formValueMap');
    log.i('siteType:$siteType');
    log.i('userRrole:$userRole');

    setBusy(true);

    try {
      // the account (user) should already be set on the previous
      // producerRegistrationView but sometimes it seems to get
      // 'lost' when restarting the app while debugging
      collectionService.account = await databaseService.getCurrentAccount();
      collectionService.team = await databaseService.getAccountTeam();

      if (useSameAddressAsProducer) {
        // if we're using the same address as the producer's registered
        // address then we can simply pass it through as we have an ID
        log.v('Using exsiting producer address for producer site');
        producerSiteAddress = producerAddress;
      } else {
        // if we're not using the same address as the registered address,
        // then we need to create a new address to for the site
        log.v('Creating producer site address');

        // let's create an address for the producer's site
        producerSiteAddress = await collectionService.createAddress(Address.instance(
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
        ));
      }
      log.v('producerSiteAddress:${producerSiteAddress!.$id}');

      // now that we have an address for the site, let's go ahead and
      // create the producer site if it doesn't already exist
      List<ProducerSite> producerSites = await collectionService.listProducerSites(
        queries: [
          Query.equal('producerId', producer.$id),
          Query.equal('siteAddressId', producerSiteAddress!.$id),
        ],
      );

      if (producerSites.isEmpty) {
        log.v('Creating producer site');

        producerSite = await collectionService.createProducerSite(
          ProducerSite.instance(
            $id: 'unique()',
            $permissions: [
              Permission.read(Role.team(collectionService.team!.$id)),
              Permission.update(Role.team(collectionService.team!.$id)),
            ],
            producerId: producer.$id,
            siteAddressId: producerSiteAddress!.$id,
            contact: useSameContactAsProducer
                ? producer.contact
                : Contact(
                    name: contactNameValue!.trim(),
                    email: contactEmailValue?.trim(),
                    phone: contactPhoneValue?.trim(),
                    mobile: contactMobileValue?.trim(),
                  ),
            tradingAs: tradingAsValue?.trim(),
            siteType: siteType!,
            canHostBinShare: siteType! == SiteType.hospitality,
            employees: (employeesValue != null && employeesValue!.trim().isNotEmpty) ? int.parse(employeesValue!.trim()) : null,
          ),
        );
      } else {
        producerSite = producerSites.first;
      }
      log.v('producerSite:${producerSite!.$id}');

      // and of course, add this user to the producer site users, if
      // they haven't already been added
      List<ProducerSiteUser> producerSiteUsers = await collectionService.listProducerSiteUsers(
        queries: [
          Query.equal('producerSiteId', producerSite!.$id),
          Query.equal('userId', collectionService.account!.$id),
        ],
      );

      if (producerSiteUsers.isEmpty) {
        log.v('Creating producer site user');

        producerSiteUser = await collectionService.createProducerSiteUser(ProducerSiteUser.instance(
          $id: 'unique()',
          $permissions: [
            Permission.read(Role.team(collectionService.team!.$id)),
            Permission.update(Role.team(collectionService.team!.$id)),
          ],
          producerSiteId: producerSite!.$id,
          userId: collectionService.account!.$id,
          userRole: userRole,
        ));
      } else {
        producerSiteUser = producerSiteUsers.first;
      }
      log.v('producerSiteUser:${producerSiteUser!.$id}');

      // the flow is slightly different to that of a successful login so
      // make sure that we set all the variables that we would typically
      // set on startup as we're expecting to use them later
      await collectionService.getProducerSitesForUser();
      await collectionService.recentActivity();
      await collectionService.getNearestBinShareAddress();

      // everything has been created correctly so we can navigate to the dashboard
      navigationService.clearStackAndShow(Routes.homeView);
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
