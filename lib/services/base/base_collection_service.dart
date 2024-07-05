import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/services/database_service.dart';

abstract class BaseCollectionService {
  final log = getLogger('CollectionService');
  final databaseService = locator<DatabaseService>();

  final Map<String, String> collectionLookups = {};
}
