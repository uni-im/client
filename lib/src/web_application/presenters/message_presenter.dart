part of web.src.im_uni_client;

class MarkdownPresenter extends Presenter {
  MarkdownMessage message;

  MarkdownPresenter(this.message);

  present() {
    return markdownToHtml(message.body);
  }
}
