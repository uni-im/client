library client.src.messages.markdown;

import 'package:client/src/messages/message.dart';

class MarkdownMessage extends Message {
  final List<Message> _children = new List<Message>();
  String body;

  MarkdownMessage();

  Iterable<Message> get children => _children;

  void add(Message m) => _children.add(m);
  bool remove(Message m) => _children.remove(m);

  @override
  Map marshal() => {'type': 'markdown', 'author': author.name, 'body': body};
}
