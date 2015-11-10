library message_presenter;

abstract class MessagePresenter
{
  String presentPlaintext(Message);
  String presentHTML(Message);
  String presentMarkdown(Message);
}

class MarkdownMessagePresenter extends MessagePresenter
{

}

class LinkPresenter extends MessagePresenter
{

}

class FilePresenter extends MessagePresenter
{

}

class ImagePresenter extends MessagePresenter
{

}