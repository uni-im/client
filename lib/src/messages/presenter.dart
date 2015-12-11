library client.src.messages.presenter;

abstract class Presenter {
  dynamic present();
}

abstract class PresenterFactory {
  Presenter getPresenter(Message);
}
