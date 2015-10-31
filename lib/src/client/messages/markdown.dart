import 'package:client/src/client/messages/message.dart';

class MarkdownMessage extends Message {
  final List<Message> _children = new List<Message>();
  String body;

  void render() {
    // TODO: implement render
  }

  Iterable<Message> get children => _children;

  void add(Message m) => _children.add(m);
  bool remove(Message m) => _children.remove(m);
}
