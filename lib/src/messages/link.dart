part of client.src.messages.message;

/// Represents a link shared by a message.
class Link extends Message {
  /// A human readable title for the link
  String title;

  /// The resource identifier for the given link
  Uri ref;

  Map marshal() {
    return new Map();
  }
}
