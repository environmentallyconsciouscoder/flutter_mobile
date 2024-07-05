import 'package:flutter_test/flutter_test.dart';
import 'package:limetrack/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CollectionServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
