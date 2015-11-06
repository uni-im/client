library client.test.utils.mocks;

import 'package:mockito/mockito.dart';

import 'package:client/src/client/channel.dart';
import 'package:client/src/client/messages/message.dart';

class MockChannel extends Mock implements Channel {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockMessage extends Mock implements Message {
  noSuchMethod(i) => super.noSuchMethod(i);
}
