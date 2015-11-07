library client.src.transports.transport_client;

import 'package:client/src/channel.dart';
import 'package:client/src/messages/message.dart';

abstract class TransportClient {
  List<Channel> _channels = new List();
  Set<Channel> _subscriptions = new Set<Channel>();

  Iterable<Channel> get channels => _channels;
  Iterable<Channel> get subscriptions => _subscriptions;

  bool join(Channel c) => _subscriptions.add(c);

  bool leave(Channel c) => _subscriptions.remove(c);

  void send(Channel c, Message m);

  void notifySubscribers(Channel c, Message m) {
    _subscriptions
        .where((Channel subscription) => subscription == c)
        .forEach((Channel c) => c.receive(m));
  }
}

class LoopbackTransportClient extends TransportClient {
  void send(Channel c, Message m) => notifySubscribers(c, m);
}
