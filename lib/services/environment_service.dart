import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:limetrack/app/app.logger.dart';

class EnvironmentService {
  final log = getLogger('EnvironmentService');

  Future initialise() async {
    log.i('Load environment variables');

    // get the build environment to use, defaulting to production if nothing selected
    String buildEnvironment = const String.fromEnvironment('ENVIRONMENT', defaultValue: '.env');

    // fetch our environment variables
    await dotenv.load(fileName: 'environments/$buildEnvironment');

    log.v('Environment variables loaded:$buildEnvironment');
  }

  /// Returns the value associated with the key
  String getValue(String key, {String fallback = 'NO_KEY', bool verbose = false}) {
    final value = dotenv.get(key, fallback: fallback);

    if (verbose) log.v('key:$key value:$value');

    return value;
  }
}
