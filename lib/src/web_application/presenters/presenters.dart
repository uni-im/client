library client.src.web_application.presenters.presenters;

import 'package:markdown/markdown.dart';

import 'package:client/src/messages/presenter.dart';
import 'package:client/src/messages/message.dart';

part 'control_presenter.dart';
part 'file_presenters.dart';
part 'message_presenter.dart';

class SimplePresenterFactory extends PresenterFactory {
  Presenter getPresenter(Message m) {
    if (m is MarkdownMessage) {
      return new MarkdownPresenter(m);
    } else if (m is Image) {
      return new ImagePresenter(m);
    } else if (m is Video) {
      return new VideoPresenter(m);
    } else if (m is FileMessage) {
      return new FilePresenter(m);
    } else {
      return new ControlPresenter(m);
    }
  }
}
