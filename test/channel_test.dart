import 'package:test/test.dart';

import 'package:client/src/channel.dart';
import 'utils/stubs.dart';

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

      channel.recieve(message);
      expect(channel.messages.contains(message), isTrue);
    });
  });
}
