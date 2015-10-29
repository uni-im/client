import 'package:test/test.dart';

import 'package:client/src/message.dart';
import 'package:client/src/channel.dart';

void main() {
  group('GroupChannel', () {
    GroupChannel channel;
    Message message;

    setUp(() {
      channel = new GroupChannel('Test Channel');
      message = new Message();
    });

    test('should add a message upon reciept', () {
      expect(channel.messages, isEmpty);

      channel.recieve(message);
      expect(channel.messages.contains(message), isTrue);
    });
  });
}
