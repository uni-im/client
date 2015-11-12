library client.src.presenters.message_presenter_factory;

import 'package:client/src/messages/message.dart';
import 'package:client/src/presenters/message_preseneter.dart';
import 'package:client/src/messages/markdown.dart';
import 'package:client/src/messages/link.dart';
import 'package:client/src/messages/file.dart';

class MessagePresenterFactory {
  static MessagePresenter getPresenter(Message m) {
    if (m is MarkdownMessage) return new MarkdownMessagePresenter();
    if (m is Link) return new LinkPresenter();
    //Image must come before File as Image is File.
    //TODO: find better solution than ordering of ifs to handle polymorphism
    if (m is Image) return new ImagePresenter();
    if (m is File) return new FilePresenter();
    throw new Exception(
        'Cannot get a message presenter for unknown message type ' +
            m.runtimeType.toString() +
            '.');
  }
}
