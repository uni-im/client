library client.src.messages.presenter;

/// A presenter is a class that is capbale of returning a single function call
/// to abstract the notion of rendering. This allows consumers of the library
/// code to specify how exactly content is presented, decoupling the view and
/// application logic.
abstract class Presenter {
  /// Return the content that reflects the nature of the message.
  dynamic present();
}

/// Uses the types of a [Message] to allow for a dynamic creationa pattern where
/// the type fo presenter returned is dependent on the depending Message.
abstract class PresenterFactory {
  Presenter getPresenter(Message);
}
