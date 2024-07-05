import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import 'package:limetrack/enums/entity_type.dart';
import 'package:limetrack/models/address.dart';
import 'package:limetrack/models/bin.dart';
import 'package:limetrack/models/caddy.dart';
import 'package:limetrack/models/lookup.dart';
import 'package:limetrack/models/producer.dart';
import 'package:limetrack/models/producer_site.dart';
import 'package:limetrack/models/producer_site_user.dart';
import 'package:limetrack/models/transfer.dart';

import 'base/base_collection_service.dart';
import 'collection_services/addresses_service.dart';
import 'collection_services/bins_service.dart';
import 'collection_services/caddies_service.dart';
import 'collection_services/carrier_vehicles_service.dart';
import 'collection_services/carriers_service.dart';
import 'collection_services/licences_service.dart';
import 'collection_services/lookups_service.dart';
import 'collection_services/networks_service.dart';
import 'collection_services/processor_sites_service.dart';
import 'collection_services/processors_service.dart';
import 'collection_services/producer_existing_contracts_service.dart';
import 'collection_services/producer_site_users_service.dart';
import 'collection_services/producer_sites_service.dart';
import 'collection_services/producers_service.dart';
import 'collection_services/transfer_notes_service.dart';
import 'collection_services/transfers_service.dart';

class CollectionService extends BaseCollectionService
    with
        AddressesService,
        BinsService,
        CaddiesService,
        CarrierVehiclesService,
        CarriersService,
        LicenceService,
        LookupsService,
        NetworkService,
        ProcessorSitesService,
        ProcessorsService,
        ProducerExistingContractsService,
        ProducerSiteUsersService,
        ProducerSitesService,
        ProducersService,
        TransferNotesService,
        TransfersService {
  models.Account? _account;
  models.Account? get account => _account;

  set account(models.Account? value) {
    _account = value;

    if (_account == null) {
      team = null;
    }
  }

  bool get isLoggedIn => _account != null;

  models.Team? team;
  bool get hasTeam => team != null;

  List<ProducerSite>? producerSites;
  List<Producer>? producers;

  int totalWeighed = 0;
  int totalCollectedWeight = 0;
  Transfer? lastWeighed;
  Transfer? lastDeposited;
  Transfer? lastCollected;
  Address? nearestBinShareAddress;

  Future<void> initialise() async {
    log.i('Initialising');

    await getCollectionLookups();

    log.v('Collection lookups mapped');
  }

  Future<void> refreshDashboardData() async {
    log.i('Refreshing dashboard data');

    await getCollectionLookups();
    await recentActivity();
    await getNearestBinShareAddress();

    log.v('Dashboard data refreshed');
  }

  Future<void> getCollectionLookups() async {
    log.i('Fetching collection lookups map');

    List<Lookup> lookups = await listLookups();

    if (lookups.isNotEmpty) {
      collectionLookups.clear();

      for (Lookup lookup in lookups) {
        collectionLookups[lookup.collectionName] = lookup.collectionId;
      }
    }

    log.v('collectionLookups:$collectionLookups');
  }

  Future<void> getProducerSitesForUser() async {
    log.i('Getting ProducerSites');

    try {
      List<ProducerSiteUser> producerSiteUsers = await listProducerSiteUsers(
        queries: [
          Query.equal('userId', account!.$id),
        ],
      );

      List<String> producerSiteList = [];

      for (var producerSiteUser in producerSiteUsers) {
        producerSiteList.add(producerSiteUser.producerSiteId);
      }

      log.v("Lookup addresses:${producerSiteList.join(',')}");

      producerSites = await listProducerSites(
        queries: [
          Query.equal('\$id', producerSiteList.join(',')),
        ],
      );

      log.v('producerSites:$producerSites');

      if (producerSites != null && producerSites!.isNotEmpty) {
        producers = await listProducers(
          queries: [
            Query.equal('\$id', producerSites!.first.producerId),
          ],
        );
      }

      log.v('producers:$producerSites');
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  Future<void> recentActivity() async {
    log.i('Getting recent activity');

    // reset everything so that we don't accidently
    // retain garbage data from a preview lookup period
    totalWeighed = 0;
    totalCollectedWeight = 0;
    lastWeighed = null;
    lastDeposited = null;
    lastCollected = null;

    try {
      // get all transfers in the last 30 days that are visible to the logged in user
      DateTime today = DateTime.now();
      DateTime last30Days = today.subtract(const Duration(days: 30));
      int firstOfMonth = DateTime(today.year, today.month, 1).millisecondsSinceEpoch;

      List<Transfer> transfers = await listTransfers(
        queries: [
          Query.greaterThanEqual('timestamp', last30Days.millisecondsSinceEpoch),
          Query.orderAsc('timestamp'),
        ],
      );

      for (Transfer transfer in transfers) {
        // if we don't have a toType then this will be a weight entered
        if ((transfer.fromType == EntityType.caddy || transfer.fromType == EntityType.producerSite) && transfer.toType == null) {
          // we only want this month's weights for the dashboard
          if (transfer.timestamp.millisecondsSinceEpoch >= firstOfMonth) {
            totalWeighed += transfer.weight ?? 0;
          }

          lastWeighed = transfer;
        }

        // if we do have a toType then this will be a weight deposited
        if ((transfer.fromType == EntityType.caddy || transfer.fromType == EntityType.producerSite) &&
            (transfer.toType != null && transfer.toType == EntityType.bin)) {
          lastDeposited = transfer;
        }

        // weight collected by carrier
        if (transfer.fromType == EntityType.bin && (transfer.toType != null && transfer.toType == EntityType.carrier)) {
          lastCollected = transfer;
        }
      }

      // we know that once we've run through all of the tranfers
      // the lastCollection will be set to the most recent
      // collection activity, and this is what we want to reflect
      // on the dashboard

      if (lastCollected != null) {
        List<Transfer> transfers = await listTransfers(
          queries: [
            Query.greaterThanEqual('timestamp', last30Days.millisecondsSinceEpoch),
            Query.equal('nextTransferId', lastCollected!.$id),
            Query.orderAsc('timestamp'),
            Query.limit(100),
          ],
        );

        for (Transfer transfer in transfers) {
          totalCollectedWeight += transfer.weight ?? 0;
        }
      }
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  Future<void> getNearestBinShareAddress() async {
    log.i('Getting nearest bin share address');
    try {
      // find all the bins that this user can see
      List<Bin> bins = await listBins(
        queries: [
          Query.notEqual('siteId', ''),
        ],
      );

      // get the address of the first bin in the list. It's currently assumed that
      // the user only has one bin assigned for sharing but later, we should find the
      // closest one in the list returned.
      if (bins.isNotEmpty) {
        List<ProducerSite> producerSites = await listProducerSites(
          queries: [
            Query.equal('\$id', bins.first.siteId),
          ],
        );

        if (producerSites.isNotEmpty) {
          List<Address> addresses = await listAddresses(
            queries: [
              Query.equal('\$id', producerSites.first.siteAddressId),
            ],
          );

          nearestBinShareAddress = addresses.first;

          log.v('Address:$nearestBinShareAddress');
        }
      }
    } on AppwriteException catch (error) {
      log.e(error.message);
    }
  }

  Future<Bin?> getBinFromCode({required String code}) async {
    log.i('Getting bin');
    try {
      models.DocumentList documentList = await databaseService.databases.listDocuments(
        databaseId: 'default',
        collectionId: collectionLookups['bins']!,
        queries: [
          Query.equal('qrCode', code),
        ],
      );

      if (documentList.total > 0) {
        log.v('Code:$code');

        return Bin.fromMap(documentList.documents.first.data);
      }
    } on AppwriteException catch (error) {
      log.e(error.message);
    }

    return null;
  }

  Future<Caddy?> getCaddyFromCode({required String code}) async {
    log.i('Getting caddy');
    try {
      models.DocumentList documentList = await databaseService.databases.listDocuments(
        databaseId: 'default',
        collectionId: collectionLookups['caddies']!,
        queries: [
          Query.equal('qrCode', code),
        ],
      );

      if (documentList.total > 0) {
        log.v('Code:$code');

        return Caddy.fromMap(documentList.documents.first.data);
      }
    } on AppwriteException catch (error) {
      log.e(error.message);
    }

    return null;
  }
}
