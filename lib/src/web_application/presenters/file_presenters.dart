part of client.src.web_application.presenters.presenters;

class FilePresenter extends Presenter {
  FileMessage message;

  FilePresenter(this.message);

  present() {
    return '''<div class="well">
      <p>${message.author.name} shared <a href="${message.uri.toString()}">a file.</a></p>
    </div>''';
  }
}

class ImagePresenter extends Presenter {
  FileMessage message;

  ImagePresenter(this.message);

  present() {
    return '''<img src="${message.uri}" />''';
  }
}

class VideoPresenter extends Presenter {
  FileMessage message;

  VideoPresenter(this.message);

  present() {
    return '''<video controls>
      <source src="${message.uri}" type="${message.contentType}">
    </video>''';
  }
}
