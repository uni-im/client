library client.src.messages.file;

import 'package:client/src/messages/message.dart';

class File extends Message {
  String title;

  File({this.title});

  @override
  Map marshal() => {'title': title};
}

class Image extends File {}
