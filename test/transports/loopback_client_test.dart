library test.transports.loopback_client_test;

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:client/client.dart';

import '../utils/mocks.dart';

main() {
  group('LoopbackTransportClient', () {
    test('should notify a channel on submission', () async {
      var client = new LoopbackTransportClient(
          new MockAgent(), new MockPresenterFactory());
      var channel = new MockChannel();
      var message = new MockMessage();

      client.join(channel);
      await client.send(channel, message);

      verify(channel.receive(message));
    });
  });
}
