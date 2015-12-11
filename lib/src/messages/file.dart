part of client.src.messages.message;

/// A [FileMessage] is a specialized message that represents a single file item
/// sent by a user.
class FileMessage extends Message {
  /// A human redable title for the file.
  String title;

  /// The resource location for the file
  Uri uri;

  /// The mime-type of the FileMessage.
  String contentType;

  FileMessage(this.uri, this.contentType);

  /// Captures the message state as a map for serialization.
  @override
  Map marshal() => {
        'author': author.name,
        'type': 'file',
        'title': title,
        'uri': uri.toString(),
        'content-type': contentType
      };
}

/// A specialized message type for Image based files.
class Image extends FileMessage {
  Image(Uri uri, String contentType) : super(uri, contentType);
}

/// A specialized message type for Video based files.
class Video extends FileMessage {
  Video(Uri uri, String contentType) : super(uri, contentType);
}
