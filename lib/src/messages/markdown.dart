part of client.src.messages.message;

/// Markdown messages allow for expressive and rich content to be conveyed
/// textually using the [Markdown Markup Style][1]. The markdown message is a
/// composite message allowing other message types to be included as children.
///
/// [1]: https://daringfireball.net/projects/markdown/
class MarkdownMessage extends Message {
  final List<Message> _children = new List<Message>();

  MarkdownMessage(String messageText) {
    body = messageText;
  }

  /// A unmodifiable collection of children messages
  Iterable<Message> get children => _children;

  /// Adds the given message as a child of the composite message
  void add(Message m) => _children.add(m);

  /// Removes the given message from the children of the composite message
  bool remove(Message m) => _children.remove(m);

  @override
  Map marshal() => {'type': 'markdown', 'author': author.name, 'body': body};
}
