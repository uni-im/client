library client.src.web_application.im_uni_client;

import 'dart:convert';
import 'dart:js' as js;
import 'dart:html';

import 'package:client/client.dart';
import 'package:client/src/transports/websocket_client.dart';
import 'package:client/src/web_application/presenters/presenters.dart';
import 'package:di/di.dart';

@Injectable()
class ImUniClient {
  TransportClient client;
  Agent currentAgent = new Agent.random();
  InputElement _fileUploadElement;
  Channel selectedChannel;
  String messageText;
  List<FileMessage> pendingFileMessages = [];

  ImUniClient() {
    WebSocket ws = new WebSocket('ws://magic-man.benjica.com:8081/v1/ws');
    SimplePresenterFactory pFactory = new SimplePresenterFactory();
    ws
      ..onOpen.first.then((_) =>
          _init(new WebSocketTransportClient(ws, currentAgent, pFactory)))
      ..onError.first.then(
          (_) => _init(new LoopbackTransportClient(currentAgent, pFactory)));

    window.onUnload
        .listen((_) => client.subscriptions.toList().forEach(client.leave));

    _fileUploadElement = querySelector("#file-upload");
    _fileUploadElement.onChange.listen((e) {
      _fileUploadElement.files.forEach((file) {
        final request = new HttpRequest();
        request.onReadyStateChange.listen((e) {
          if (request.readyState == HttpRequest.DONE) {
            var json = JSON.decode(request.response.toString());
            var uri = Uri.parse(json['link']);
            var contentType = json['content-type'];

            sendFile(uri, contentType);
          }
        });
        request.open('POST', 'http://magic-man.benjica.com:8081/v1/upload');
        request.send(new FormData()..appendBlob('file', file));
      });
    });
  }

  void _init(TransportClient c) {
    client = c;

    // TODO: Implement channel persistence across server
    ['foo', 'bar', 'biz'].map(client.createChannel).forEach(client.join);
    selectedChannel = client.channels.first;
  }

  void selectChannel(Channel c) {
    selectedChannel = c;
  }

  void sendMessage() {
    MarkdownMessage m = client.messageFactory.createMessage(messageText);
    m.author = currentAgent;
    client.send(selectedChannel, m);

    (querySelector("#messageInput") as InputElement).value = "";
  }

  int get totalUnviewedMessages {
    if (client != null) {
      return client.channels
          .map((c) => c.unviewedMessages.length)
          .reduce((sum, count) => sum + count);
    } else {
      return 0;
    }
  }

  void sendFile(Uri uri, String contentType) {
    var message = client.messageFactory.createFileMessage(uri, contentType);
    message.author = currentAgent;

    client.send(selectedChannel, message);
  }

  void openFileSelector() {
    InputElement file = querySelector("#file-upload");
    file.click();
  }

  void openMultilineEditor() {
    js.context.callMethod(r'$', ['#multiline-modal']).callMethod('modal', [
      new js.JsObject.jsify({'show': true})
    ]);
  }

  void sendMultilineMessage() {
    InputElement inputElement = querySelector("#multiline-message-text-area");
    MarkdownMessage message =
        client.messageFactory.createMessage(inputElement.value);
    message.author = currentAgent;

    client.send(selectedChannel, message);

    // TODO: Maybe handle submission errors without dismissing modal
    inputElement.value = "";
    js.context.callMethod(r'$', ['#multiline-modal'])
        .callMethod('modal', ['hide']);
  }
}
