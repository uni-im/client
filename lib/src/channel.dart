library client.src.channel;

import 'package:client/src/messages/message.dart';
import 'package:client/src/agent.dart';

/// Allows for the aggreation of messages into a list based on a logical
/// division.
abstract class Channel {
  List<Message> _messages = new List<Message>();

  /// The immutable collection of messages currently recived by the channel.
  Iterable<Message> get messages => _messages;

  /// A unique identifying title for the channel.
  String title;

  /// Appends the given message to the list of messages within the channnel.
  /// This is principally used by the observer pattern to recieve dispatched
  /// message updates from the transport.
  void receive(Message m) => _messages.add(m);

  /// A filtering of messages within the channel that have not been marked
  /// viewed.
  Iterable<Message> get unviewedMessages =>
      _messages.where((m) => !(m?.viewed ?? true));
}

/// Represents a channel that has more than two principal agents. This is the
/// tradtional notion of chat room in which many agents are able to send
/// messages to one another.
class GroupChannel extends Channel {
  List<Agent> _agents = new List<Agent>();

  /// A topic allows channel agents to update a small snippet indicating the
  /// purpose of the channel at the current moment.
  String topic;

  /// Channels are recursive allowing any [GroupChannel] to have a parent
  /// [Channel].
  Channel parent;

  GroupChannel(String channelName) {
    title = channelName;
  }

  /// Channels are recursive allowing any [GroupChannel] to have many child
  /// channels.
  Iterable<Channel> subChannels = [];

  /// Lists all of agents registered to the given channel.
  Iterable<Agent> get members => _agents;
}

/// Creates a channel in there is only one member allowing for 1 to 1
/// communication with an opposing agent.
class PrivateChannel extends Channel {
  Agent _agent;

  /// The only member of a [PrivateChannel] is a single agent.
  Agent get member => _agent;

  /// The title of a 1 to 1 channel is the name of the other agent.
  String get title => _agent.name;
}
