import 'package:client/src/message.dart';
import 'package:client/src/agent.dart';
import 'package:client/src/FileFactory.dart';

abstract class Channel {
  List<Message> _messages = new List<Message>();
  FileFactory _fileFactory;

  FileFactory get files => _fileFactory;
  Iterable<Message> get messages => _messages;

  void recieve(Message m) => _messages.add(m);

  String get title;
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
