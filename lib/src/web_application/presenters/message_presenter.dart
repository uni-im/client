part of client.src.web_application.presenters.presenters;

class MarkdownPresenter extends Presenter {
  MarkdownMessage message;

  MarkdownPresenter(this.message);

  present() {
    return markdownToHtml(message.body);
  }
}
