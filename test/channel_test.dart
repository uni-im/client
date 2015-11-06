import 'package:test/test.dart';

import 'package:client/src/client/channel.dart';
import 'utils/mocks.dart';

void main() {
  group('GroupChannel', () {
    GroupChannel channel;
    MockMessage message;

    setUp(() {
      channel = new GroupChannel('Test Channel');
      message = new MockMessage();
    });

    test('should add a message upon reciept', () {
      expect(channel.messages, isEmpty);

      channel.receive(message);
      expect(channel.messages.contains(message), isTrue);
    });
  });
}
