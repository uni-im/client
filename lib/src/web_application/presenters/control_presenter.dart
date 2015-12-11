part of client.src.web_application.presenters.presenters;

class ControlPresenter extends Presenter {
  ControlMessage message;

  ControlPresenter(this.message);

  present() => '<em>${message.body}</em>';
}
