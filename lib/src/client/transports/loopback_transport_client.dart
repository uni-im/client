library client.src.client.transports.loopback_transport_client;

import 'package:client/src/client/channel.dart';
import 'package:client/src/client/messages/message.dart';
import 'package:client/src/client/transports/transport_client.dart';

class LoopbackTransportClient extends TransportClient {
  LoopbackTransportClient() {
    // Stock channels
    ["alpha", "beta", "gamma"].forEach(createChannel);

    channels.forEach(join);
  }

  void send(Channel c, Message m) => notifySubscribers(c, m);
}
