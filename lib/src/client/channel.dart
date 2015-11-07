library client.src.client.channel;

import 'package:client/src/client/messages/message.dart';
import 'package:client/src/client/agent.dart';
import 'package:client/src/client/file_factory.dart';

abstract class Channel {
  List<Message> _messages = new List<Message>();
  FileFactory _fileFactory;

  String title;

  FileFactory get files => _fileFactory;
  Iterable<Message> get messages => _messages;

  void receive(Message m) => _messages.add(m);
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
