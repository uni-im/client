import 'package:client/src/message.dart';

abstract class Channel {
  List<Message> _messages = new List<Message>();

  Channel();

  Iterable<Message> get messages => _messages;

  void recieve(Message m) => _messages.add(m);
}

class GroupChannel extends Channel {
  String title;
  String topic;
  Channel parent;
  Iterable<Channel> subChannels;

  GroupChannel(this.title) : super();
}

class PrivateChannel extends Channel {}
