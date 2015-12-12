part of client.src.web_application.presenters.presenters;

/// A markdown presenter is capable of parsing Markdown formatted text and
/// injects the parsed result of such text into the DOM.
class MarkdownPresenter extends Presenter {
  MarkdownMessage message;

  MarkdownPresenter(this.message);

  /// provides the markdown formatted text as input to a parsing and returns
  /// the associated html for rendering in the DOM.
  present() {
    return markdownToHtml(message.body);
  }
}
