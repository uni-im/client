library client.src.messages.client;

import 'package:client/src/messages/message.dart';

class ControlMessage extends Message {
  String body;
  final bool isControl = true;
  bool viewed = true;

  ControlMessage(this.body);

  @override
  Map marshal() => {};
}
