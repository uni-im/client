library message_presenter;

import 'package:client/src/messages/message.dart';
import 'package:client/src/presenters/message_preseneter.dart';
import 'package:client/src/messages/markdown.dart';
import 'package:client/src/messages/link.dart';
import 'package:client/src/messages/file.dart';

abstract class PresenterFactory {
  MessagePresenter getPresenter(Message);
}

class MessagePresenterFactory {
  MessagePresenter getPresenter(Message m) {
    if (m is MarkdownMessage) return new MarkdownMessagePresenter();
    if (m is Link) return new LinkPresenter();
    if (m is File) return new FilePresenter();
    if (m is Image) return new ImagePresenter();
    throw new Exception(
        'Cannot get a message presenter for unknown message type ' +
            m.runtimeType.toString() +
            '.');
  }
}
