library client.src.transports.transport_client;

import 'dart:async';

import 'package:client/src/channel.dart';
import 'package:client/src/messages/message.dart';

part 'loopback_transport_client.dart';

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
