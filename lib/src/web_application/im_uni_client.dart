library client.src.web_application.im_uni_client;

import 'dart:convert';
import 'dart:js' as js;
import 'dart:html';

import 'package:client/client.dart';
import 'package:client/src/transports/websocket_client.dart';
import 'package:client/src/web_application/presenters/presenters.dart';
import 'package:di/di.dart';

/// Provides a facade over the application encapsulating the application logic
@Injectable()
class UniImClientFacade {
  /// The mechanism in which message state is serialized and transported
  TransportClient client;

  /// The currently viewing agent
  Agent currentAgent = new Agent.random();

  /// A reference to the input element within the web application where files
  /// are chosen.
  InputElement _fileUploadElement;

  /// The current channel the application is viewing
  Channel selectedChannel;
  List<FileMessage> pendingFileMessages = [];

  UniImClientFacade() {
    // Create a new websocket to a development instance of the backend service
    WebSocket ws = new WebSocket('ws://magic-man.benjica.com:8081/v1/ws');
    SimplePresenterFactory pFactory = new SimplePresenterFactory();

    // Handle success and failure events for the websocket
    ws
      ..onOpen.first.then((_) =>
          // Intialize the [TransportClient]
          _init(new WebSocketTransportClient(ws, currentAgent, pFactory)))
      ..onError.first.then(
          // Any error on the websocket causes the client to use a loopback
          // tranposrt client.
          (_) => _init(new LoopbackTransportClient(currentAgent, pFactory)));

    // When the user leaves the web application unsubscribed from all subscribed
    // channels.
    window.onUnload
        .listen((_) => client.subscriptions.toList().forEach(client.leave));

    _fileUploadElement = querySelector("#file-upload");

    // Listen for changes to the file input element to perform uploads
    _fileUploadElement.onChange.listen((e) {
      _fileUploadElement.files.forEach((file) {
        final request = new HttpRequest();
        request.onReadyStateChange.listen((e) {
          if (request.readyState == HttpRequest.DONE) {
            // parse the output returned form the file upload for file upload
            // meta data
            var json = JSON.decode(request.response.toString());
            var uri = Uri.parse(json['link']);
            var contentType = json['content-type'];

            // Send message with the file meta data
            sendFile(uri, contentType);
          }
        });
        // create an connection to the development backend instance.
        request.open('POST', 'http://magic-man.benjica.com:8081/v1/upload');
        request.send(new FormData()..appendBlob('file', file));
      });
    });
  }

  /// An initilization funciton called on the resovlment of the websocket
  /// connection future.
  void _init(TransportClient c) {
    client = c;

    // TODO: Implement channel persistence across server
    // Creates a list of channels to use on applicaiton initialization
    ['CSCI315 Computer Ethics', 'CSCI426 Advanced Programming']
        .map(client.createChannel)
        .forEach(client.join);

    // The first channel in the list is the active chanel
    selectedChannel = client.channels.first;
  }

  /// Updates the currently selected channel
  void selectChannel(Channel c) {
    selectedChannel = c;
  }

  /// Gets the content of an input element of the application and creates a new
  /// markdown message. This is submitted to the transport client.
  void sendMessage() {
    InputElement input = querySelector("#messageInput");
    MarkdownMessage m =
        client.messageFactory.createMarkdownMessage(input.value);
    m.author = currentAgent;
    client.send(selectedChannel, m);

    // Reset input field to indicate message was sent
    input.value = "";
  }

  /// A filter for aggragatting the total number of unviewed messages for all
  /// channels
  int get totalUnviewedMessages {
    if (client != null) {
      return client.channels
          .map((c) => c.unviewedMessages.length)
          .reduce((sum, count) => sum + count);
    } else {
      return 0;
    }
  }

  /// Instantiates a new FileMessage with the given paramemters and submits it
  /// to the client.
  void sendFile(Uri uri, String contentType) {
    var message = client.messageFactory.createFileMessage(uri, contentType);
    message.author = currentAgent;

    client.send(selectedChannel, message);
  }

  /// Activates the hidden file input element causing an upload dialog to open.
  void openFileSelector() {
    InputElement file = querySelector("#file-upload");
    file.click();
  }

  /// Uses the bootstrap Modal functionality to show the multiline editor modal
  /// in the window.
  void openMultilineEditor() {
    js.context.callMethod(r'$', ['#multiline-modal']).callMethod('modal', [
      new js.JsObject.jsify({'show': true})
    ]);
  }

  /// Gets the contents of the multiline input element and creates a markdown
  /// message.
  void sendMultilineMessage() {
    InputElement inputElement = querySelector("#multiline-message-text-area");
    MarkdownMessage message =
        client.messageFactory.createMarkdownMessage(inputElement.value);
    message.author = currentAgent;

    client.send(selectedChannel, message);

    // TODO: Maybe handle submission errors without dismissing modal
    // Clear the input element value and hide the modal to indicate the message
    // was sent.
    inputElement.value = "";
    js.context.callMethod(r'$', ['#multiline-modal'])
        .callMethod('modal', ['hide']);
  }
}
