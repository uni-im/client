library client.src.channel;

import 'package:client/src/messages/message.dart';
import 'package:client/src/agent.dart';

abstract class Channel {
  List<Message> _messages = new List<Message>();

  Iterable<Message> get messages => _messages;

  void receive(Message m) => _messages.add(m);

  String get title;

  Iterable<Message> get unviewedMessages =>
      _messages.where((m) => !(m?.viewed ?? true));
}

class GroupChannel extends Channel {
  List<Agent> _agents = new List<Agent>();
  String title;
  String topic;
  Channel parent;

  Iterable<Channel> subChannels;

  GroupChannel(this.title) : super();

  Iterable<Agent> get members => _agents;
}

class PrivateChannel extends Channel {
  Agent _agent;

  Agent get member => _agent;
  String get title => _agent.name;
}
