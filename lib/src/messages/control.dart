library client.src.messages.client;

import 'package:client/src/messages/message.dart';

class ControlMessage extends Message {
  String body;
  final bool isControl = true;

  ControlMessage(this.body);

  dynamic render() => presenter.present();

  @override
  Map marshal() => {};
}
