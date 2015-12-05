library client.src.messages.message;

import 'package:client/src/agent.dart';
import 'package:client/src/messages/markdown.dart';
import 'package:client/src/messages/presenter.dart';
import 'package:client/src/messages/control.dart';

class MessageFactory {
  PresenterFactory presenterFactory;

  MessageFactory(this.presenterFactory);

  Message fromJson(Map payload) {
    if (payload['type'] == null) {
      throw new ArgumentError.notNull('data payload type');
    }
    switch (payload['type']) {
      case 'markdown':
        var message = new MarkdownMessage();
        message.presenter = presenterFactory.getPresenter(message);
        message.author = new Agent(payload['author']);
        message.body = payload['body'];
        return message;
    }

    return null;
  }

  Message createMessage(String messageText) {
    var message = new MarkdownMessage()..body = messageText;
    message.presenter = presenterFactory.getPresenter(message);

    return message;
  }

  ControlMessage controlMessage(String messageText) {
    var message = new ControlMessage(messageText);
    message.presenter = presenterFactory.getPresenter(message);

    return message;
  }
}

abstract class Message {
  Agent author;
  Presenter presenter;
  final bool isControl = false;
  bool viewed = false;

  render() {
    viewed = true;
    return presenter.present();
  }

  // TODO: Write what a sublcass of a message must do upon marshal
  Map marshal();
}
