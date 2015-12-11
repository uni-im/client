part of client.src.web_application.presenters.presenters;

/// Provides and HTML based presenter for ControlMessages
class ControlPresenter extends Presenter {
  ControlMessage message;

  ControlPresenter(this.message);

  /// Any control message is injected into the dom as italicized text
  present() => '<em>${message.body}</em>';
}
