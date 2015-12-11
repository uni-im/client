part of client.src.messages.message;

/// Provides a generalized creational mechanism for standing up new [Message]
/// classes.
class MessageFactory {
  /// The creational tool used to get instances of a presenter class for a
  /// specific [Message].
  PresenterFactory presenterFactory;

  /// A creational tool used to get instances of specific [FileMessage]s.
  FileMessageFactory fileMessageFactory;

  MessageFactory(this.presenterFactory) {
    fileMessageFactory = new FileMessageFactory();
  }

  /// A demarshalling call that takes a payload as an argument. This payload
  /// must be a valid json representation of a message. The factory is able to
  /// inflate messages that have traverssed the network.
  Message fromJson(Map payload) {
    // Throw exception if the payload has no explict type.
    if (payload['type'] == null) {
      throw new ArgumentError.notNull('data payload type');
    }

    Message message;

    // Create the message object with the correct 'type'
    switch (payload['type']) {
      case 'markdown':
        message = new MarkdownMessage(payload['body']);
        break;
      case 'file':
        // Defer creation to [FileMessageFactory]
        var uri = Uri.parse(payload['uri']);
        var contentType = payload['content-type'];
        message = fileMessageFactory.createFileMessage(uri, contentType);
        break;
    }

    // Inject a presenter as returned by the presenter factory
    message.presenter = presenterFactory.getPresenter(message);
    message.author = new Agent(payload['author']);

    return message;
  }

  /// Stands up a [MarkdownMessage]
  MarkdownMessage createMarkdownMessage(String messageText) {
    var message = new MarkdownMessage(messageText);
    message.presenter = presenterFactory.getPresenter(message);

    return message;
  }

  /// Stands up a [FileMessage]
  FileMessage createFileMessage(Uri uri, String contentType) {
    FileMessage message =
        fileMessageFactory.createFileMessage(uri, contentType);

    message.presenter = presenterFactory.getPresenter(message);

    return message;
  }

  /// Stands up a [ControlMessage]
  ControlMessage createControlMessage(String messageText) {
    var message = new ControlMessage(messageText);
    message.presenter = presenterFactory.getPresenter(message);

    return message;
  }
}
