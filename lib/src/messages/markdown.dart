library client.src.messages.markdown;

import 'package:client/src/messages/message.dart';
import 'package:client/src/agent.dart';

class MarkdownMessage extends Message {
  final List<Message> _children = new List<Message>();
  String body;

  MarkdownMessage(this.body);

  factory MarkdownMessage.fromMap(Map data) {
    var message = new MarkdownMessage(data['body']);
    return message;
  }

  void render() {
    // TODO: implement render
  }

  Iterable<Message> get children => _children;

  void add(Message m) => _children.add(m);
  bool remove(Message m) => _children.remove(m);

  @override
  Map marshal() => {'type': 'markdown', 'author': author.name, 'body': body};
}
