import 'package:client/src/client/channel.dart';
import 'package:client/src/client/messages/message.dart';
import 'dart:async';

abstract class TransportClient {
  List<Channel> _channels = new List();
  Set<Channel> _subscriptions = new Set<Channel>();

  Iterable<Channel> get channels => _channels;
  Iterable<Channel> get subscriptions => _subscriptions;

  void createChannel(String name) => _channels.add(new GroupChannel(name));

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
  LoopbackTransportClient() {
    // Stock channels
    ["alpha", "beta", "gamma"].forEach(createChannel);

    channels.forEach(join);

    new Timer.periodic(new Duration(seconds: 2), (Timer t) {
      var randomChannel = (channels.toList()..shuffle()).first;
      var now = new DateTime.now();
      send(randomChannel, new TextMessage("$now - Hello world!"));
    });
  }

  void send(Channel c, Message m) => notifySubscribers(c, m);
}
