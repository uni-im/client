library test.transports.transport_client_test;

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:client/src/transports/transport_client.dart';

import '../utils/mocks.dart';

void main() {
  group('TransportClient', () {
    LoopbackTransportClient client;
    MockChannel channel;

    setUp(() {
      client = new LoopbackTransportClient();
      channel = new MockChannel();
    });

    test('should add channel to subscriptions on join', () {
      client.join(channel);
      expect(client.subscriptions.contains(channel), isTrue);
    });

    test('should remove channel from subscriptions on leave', () {
      client.join(channel);
      expect(client.subscriptions.contains(channel), isTrue);

      client.leave(channel);
      expect(client.subscriptions.contains(channel), isFalse);
    });

    test('should notify correct channel', () {
      List<MockChannel> channels = [new MockChannel(), new MockChannel()];
      MockMessage message = new MockMessage();

      channels.forEach(client.join);
      client.notifySubscribers(channels[1], message);

      verifyNever(channels.first.receive(message));
      verify(channels.last.receive(message));
    });

    test('should create channel', () {
      var channel = client.createChannel('Test Channel');
      expect(client.channels.contains(channel), isTrue);
    });
  });
}
