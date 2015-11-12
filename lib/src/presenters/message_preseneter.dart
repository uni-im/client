library message_presenter;

abstract class MessagePresenter
{
  String presentPlaintext(Message);
  String presentHTML(Message);
  String presentMarkdown(Message);
}

class MarkdownMessagePresenter extends MessagePresenter
{

  @override
  String presentHTML(Message) {
    // TODO: implement presentHTML
  }

  @override
  String presentMarkdown(Message) {
    // TODO: implement presentMarkdown
  }

  @override
  String presentPlaintext(Message) {
    // TODO: implement presentPlaintext
  }
}

class LinkPresenter extends MessagePresenter
{
  @override
  String presentHTML(Link) => '<a href="' + Link.getRef() + '">' + Link.getTitle() + '</a>';

  @override
  String presentMarkdown(Link) => '[' + Link.getTitle() + '](' + Link.getRef() + ')';

  @override
  String presentPlaintext(Link) => Link.getTitle() + '\t-\t' + Link.getRef();
}

class FilePresenter extends MessagePresenter
{

  @override
  String presentHTML(Message) {
    // TODO: implement presentHTML
  }

  @override
  String presentMarkdown(Message) {
    // TODO: implement presentMarkdown
  }

  @override
  String presentPlaintext(Message) {
    // TODO: implement presentPlaintext
  }
}

class ImagePresenter extends MessagePresenter
{

  @override
  String presentHTML(Message) {
    // TODO: implement presentHTML
  }

  @override
  String presentMarkdown(Message) {
    // TODO: implement presentMarkdown
  }

  @override
  String presentPlaintext(Message) {
    // TODO: implement presentPlaintext
  }
}