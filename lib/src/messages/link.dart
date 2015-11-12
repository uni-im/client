library client.src.messages.link;

import 'package:client/src/messages/message.dart';

class Link extends Message {
  String title;
  Uri ref;

  Link(String url) {
    ref = Uri.parse(url);
  }

  void render() {
    // TODO: implement render
  }

  Map marshal() {
    return new Map();
  }

  String getTitle() => title;
  Uri getRef() => ref;
}
