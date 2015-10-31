import 'package:mockito/mockito.dart';

import 'package:client/src/channel.dart';

class MockChannel extends Mock implements Channel {
  noSuchMethod(i) => super.noSuchMethod(i);
}
