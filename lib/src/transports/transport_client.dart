library client.src.transports.transport_client;

import 'dart:async';
import 'dart:convert';

import 'package:client/src/channel.dart';
import 'package:client/src/messages/message.dart';
import 'package:client/src/messages/presenter.dart';
import 'package:client/src/agent.dart';

part 'loopback_transport_client.dart';
part 'transport_atoms.dart';

/// The base class that implements an observer pattern for message state changes
/// that are recived by a distribution mechanism.
abstract class TransportClient {
  /// The agent that represents the identity of the current user
  Agent agent;

  /// A collection of available channels
  List<Channel> _channels = new List();

  /// A collection of subscribed channels
  Set<Channel> _subscriptions = new Set<Channel>();

  /// A factory object responsible for instantiating new message objects.
  MessageFactory messageFactory;

  TransportClient(this.agent, PresenterFactory pFactory) {
    messageFactory = new MessageFactory(pFactory);
  }

  /// An unmodifiable collection representing available channels
  Iterable<Channel> get channels => _channels;

  /// An unmoifiable collection representing currently subscribed channels.
  Iterable<Channel> get subscriptions => _subscriptions;

  /// Adds subscription to receive notify events from the subject.
  bool join(Channel c) => _subscriptions.add(c);

  /// Removes subscription to notify events from the subject.
  bool leave(Channel c) => _subscriptions.remove(c);

  /// Concrete implementations of the [TransportClient] must implement how
  /// new state is communicated by the client. This handels serialization and
  /// propagation of a message on a given channel.
  void send(Channel c, Message m);

  /// Allows observers of the subject to recive updates when new state is
  /// recieved by the TransportClient.
  void notifySubscribers(Channel c, Message m) {
    _subscriptions
        .where((Channel subscription) => subscription == c)
        .forEach((Channel c) => c.receive(m));
  }

  /// A factory functon for instantiating new Channels when such a channel is
  /// not available in [channels].
  Channel createChannel(String channelName) {
    Channel channel = new GroupChannel(channelName);
    _channels.add(channel);
    return channel;
  }
}
