import 'package:client/src/messages/message.dart';

class File extends Message {
  String title;

  File({this.title});

  void render() {
    // TODO: implement render
  }
}

class Image extends File {
  void render() {
    // TODO: An image will render in line
  }
}
