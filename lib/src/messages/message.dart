library client.src.messages.message;

import 'package:client/src/messages/markdown.dart';

abstract class Message {
  Message();

  /// The unmarshal factory function is used to instantiate messages based on
  /// the type encoded in the marshaled format.
  factory Message.unmarshal(Map payload) {
    if (payload['type'] == null) {
      throw new ArgumentError.notNull('data payload type');
    }

    // TODO: switch to enums for profit and value
    // TODO: add other message types
    switch (payload['type']) {
      case 'markdown':
        return new MarkdownMessage.fromMap(payload);
      default:
        // TODO: Define some default type of message
        print('Recieved unknown message type: ${payload['type']}');
    }
  }

  // TODO: Write what a subclass of a message must do upon a render
  void render();

  // TODO: Write what a sublcass of a message must do upon marshal
  Map marshal();
}
