part of client.src.messages.message;

/// A factory class responsible for producing [FileMessage] objects that are
/// dynamically created based on the the given contentType.
class FileMessageFactory {
  /// Creates a [FileMessage] that may have extended functionality if the
  /// content type is supported.
  FileMessage createFileMessage(Uri uri, String contentType) {
    if (contentType.startsWith("image/")) {
      return new Image(uri, contentType);
    } else if (contentType.startsWith("video/")) {
      return new Video(uri, contentType);
    } else {
      // Any file that is not specialized by content type defaults to the
      // default implementation of a [FileMessage].
      return new FileMessage(uri, contentType);
    }
  }
}
