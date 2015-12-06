library client.src.messages.message;

import 'package:client/src/agent.dart';
import 'package:client/src/messages/presenter.dart';

part 'control.dart';
part 'file.dart';
part 'markdown.dart';

abstract class Message {
  Agent author;
  Presenter presenter;
  final bool isControl = false;

  render() => presenter.present();

  // TODO: Write what a sublcass of a message must do upon marshal
  Map marshal();
}

class MessageFactory {
  PresenterFactory presenterFactory;
  FileMessageFactory fileMessageFactory;

  MessageFactory(this.presenterFactory) {
    fileMessageFactory = new FileMessageFactory();
  }

  Message fromJson(Map payload) {
    if (payload['type'] == null) {
      throw new ArgumentError.notNull('data payload type');
    }

    Message message;

    switch (payload['type']) {
      case 'markdown':
        message = new MarkdownMessage(payload['body']);
        break;
      case 'file':
        var uri = Uri.parse(payload['uri']);
        var contentType = payload['content-type'];
        message = fileMessageFactory.createFileMessage(uri, contentType);
        break;
    }

    message.presenter = presenterFactory.getPresenter(message);
    message.author = new Agent(payload['author']);

    return message;
  }

  Message createMessage(String messageText) {
    // TODO: Unify factory method names
    var message = new MarkdownMessage(messageText);
    message.presenter = presenterFactory.getPresenter(message);

    return message;
  }

  FileMessage createFileMessage(Uri uri, String contentType) {
    // TODO: Unify factory method names
    FileMessage message =
        fileMessageFactory.createFileMessage(uri, contentType);

    message.presenter = presenterFactory.getPresenter(message);

    return message;
  }

  ControlMessage controlMessage(String messageText) {
    // TODO: Unify factory method names
    var message = new ControlMessage(messageText);
    message.presenter = presenterFactory.getPresenter(message);

    return message;
  }
}
