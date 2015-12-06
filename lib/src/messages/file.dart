part of client.src.messages.message;

class FileMessageFactory {
  FileMessage createFileMessage(Uri uri, String contentType) {
    if (contentType.startsWith("image/")) {
      return new Image(uri, contentType);
    } else if (contentType.startsWith("video/")) {
      return new Video(uri, contentType);
    } else {
      return new FileMessage(uri, contentType);
    }
  }
}

class FileMessage extends Message {
  String title;
  Uri uri;
  String contentType;

  FileMessage(this.uri, this.contentType);

  @override
  Map marshal() => {
        'author': author.name,
        'type': 'file',
        'title': title,
        'uri': uri.toString(),
        'content-type': contentType
      };
}

class Image extends FileMessage {
  Image(Uri uri, String contentType) : super(uri, contentType);
}

class Video extends FileMessage {
  Video(Uri uri, String contentType) : super(uri, contentType);
}
