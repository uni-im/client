part of client.src.web_application.presenters.presenters;

/// The generic presenter for file objects. This allows any file to represented
/// as a well object within the DOM with a link to the file resource.
class FilePresenter extends Presenter {
  FileMessage message;

  FilePresenter(this.message);

  /// New generic files have a generic container within the dom and a link to
  /// the file.
  present() {
    return '''<div class="well">
      <p>${message.author.name} shared <a href="${message.uri.toString()}">a file.</a></p>
    </div>''';
  }
}

/// A specialized FilePresenter that embeds an image within the DOM.
class ImagePresenter extends Presenter {
  FileMessage message;

  ImagePresenter(this.message);

  /// An image tag is returned for image messages.
  present() {
    return '''<img src="${message.uri}" />''';
  }
}

/// A specialized FilePresenter that embeds an video within the DOM.
class VideoPresenter extends Presenter {
  FileMessage message;

  VideoPresenter(this.message);

  /// A video tag is returned for injection into the DOM.
  present() {
    return '''<video controls>
      <source src="${message.uri}" type="${message.contentType}">
    </video>''';
  }
}
