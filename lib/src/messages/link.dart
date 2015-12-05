library client.src.messages.link;

import 'package:client/src/messages/message.dart';

class Link extends Message {
  String title;
  Uri ref;

  Map marshal() {
    return new Map();
  }
}
