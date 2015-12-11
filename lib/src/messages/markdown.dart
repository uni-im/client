part of client.src.messages.message;

class MarkdownMessage extends Message {
  final List<Message> _children = new List<Message>();
  String body;

  MarkdownMessage(this.body);

  Iterable<Message> get children => _children;

  void add(Message m) => _children.add(m);
  bool remove(Message m) => _children.remove(m);

  @override
  Map marshal() => {'type': 'markdown', 'author': author.name, 'body': body};
}
