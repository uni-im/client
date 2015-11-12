library message_presenter;
import 'package:client/src/messages/link.dart';
import 'package:client/src/messages/message.dart';

abstract class MessagePresenter
{
  String presentPlaintext(Message m);
  String presentHTML(Message m);
  String presentMarkdown(Message m);
}

class MarkdownMessagePresenter extends MessagePresenter
{

  @override
  String presentHTML(Message m) {
    // TODO: implement presentHTML
  }

  @override
  String presentMarkdown(Message m) {
    // TODO: implement presentMarkdown
  }

  @override
  String presentPlaintext(Message m) {
    // TODO: implement presentPlaintext
  }
}

class LinkPresenter extends MessagePresenter
{
  @override
  String presentHTML(Link l) => '<a href="' + l.getRef().toString() + '">' + l.getTitle() + '</a>';

  @override
  String presentMarkdown(Link l) => '[' + l.getTitle() + '](' + l.getRef().toString() + ')';

  @override
  String presentPlaintext(Link l) => l.getTitle() + '\t-\t' + l.getRef().toString();
}

class FilePresenter extends MessagePresenter
{

  @override
  String presentHTML(Message m) {
    // TODO: implement presentHTML
  }

  @override
  String presentMarkdown(Message m) {
    // TODO: implement presentMarkdown
  }

  @override
  String presentPlaintext(Message m) {
    // TODO: implement presentPlaintext
  }
}

class ImagePresenter extends MessagePresenter
{

  @override
  String presentHTML(Message m) {
    // TODO: implement presentHTML
  }

  @override
  String presentMarkdown(Message m) {
    // TODO: implement presentMarkdown
  }

  @override
  String presentPlaintext(Message m) {
    // TODO: implement presentPlaintext
  }
}