library client.src.messages.link;

import 'package:client/src/messages/message.dart';

class Link extends Message {
  String _title;
  Uri _ref;

  String get title => _title;
  Uri get ref => _ref;

  Link(String url) {
    _ref = Uri.parse(url);
  }

  void render() {
    // TODO: implement render
  }

  Map marshal() {
    return new Map();
  }
}
