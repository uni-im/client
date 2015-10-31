import 'dart:async';

import 'package:client/src/client/messages/file.dart';

class FileFactory {
  Future<File> createFile() async {
    return new File();
  }
}
