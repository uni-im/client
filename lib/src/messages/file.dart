library client.src.messages.file;

import 'package:client/src/messages/message.dart';

class File extends Message {
  String title;

  File({this.title});

  @override
  void render() {
    // TODO: implement render
  }

  @override
  Map marshal() => {'title': title};
}

class Image extends File {
  @override
  void render() {
    // TODO: An image will render in line
  }
}
