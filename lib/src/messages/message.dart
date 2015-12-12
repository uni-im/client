library client.src.messages.message;

import 'package:client/src/agent.dart';
import 'package:client/src/messages/presenter.dart';

part 'control.dart';
part 'factories/message_factory.dart';
part 'factories/file_message_factory.dart';
part 'file.dart';
part 'markdown.dart';

/// The general message caputers all state relevent to any message.
abstract class Message {
  /// The author of the message.
  Agent author;

  /// The body of the message including all renderable text
  String body;

  /// The presenter delegate that produces an application indepdent output for
  /// the message.
  Presenter presenter;

  /// A flag of wether the message has been rendered.
  bool viewed = false;

  /// Provides a mechanism to generate the body of a message as a value returned
  /// by the presenter.
  render() {
    viewed = true;
    return presenter.present();
  }

  /// Any message that becomes serialized must provide an implementation of the
  /// marshalling function which returns a general datastructure that is used
  /// by a transport.
  Map marshal();
}
