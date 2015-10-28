import 'package:test/test.dart';

import 'package:client/src/channel.dart';
import 'package:client/src/message.dart';
import 'package:client/src/transport_client.dart';

import 'stubs.dart';

void main() {
  group('TransportClient', () {
    TransportClient client;

    setUp(() {
      client = new TransportClient();
    });

    test('should add channel to subscriptions on join', () {
      var channel = new Channel();

      client.join(channel);
      expect(client.subscriptions.contains(channel), isTrue);
    });

    test('should remove channel from subscriptions on leave', () {
      var channel = new Channel();

      client.join(channel);
      expect(client.subscriptions.contains(channel), isTrue);

      client.leave(channel);
      expect(client.subscriptions.contains(channel), isFalse);
    });

    test('should notify correct channel', () {
      List<StubChannel> channels = [new StubChannel(), new StubChannel()];
      Message message = new Message();

      channels.forEach(client.join);
      client.notifySubscribers(channels[1], message);

      expect(channels[0].notified, isFalse);
      expect(channels[1].notified, isTrue);
    });

    test('should notify subscribed channel when sending message', () {
      var channel = new StubChannel();
      var message = new Message();
      client.join(channel);
      client.send(channel, message);

      expect(channel.notified, isTrue);
      expect(channel.notifyMessage, same(message));
    });
  });
}
