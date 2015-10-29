import 'package:client/src/message.dart';

abstract class Channel {
  List<Message> _messages = new List<Message>();
  final String name;

  Channel(this.name);

  Iterable<Message> get messages => _messages;

  void recieve(Message m) => _messages.add(m);
}

class GroupChannel extends Channel {
  GroupChannel(String name) : super(name);
}
