import 'package:angular/application_factory.dart';
import 'package:di/annotations.dart';
import 'package:client/client.dart';
import 'dart:html';
import 'package:client/src/transports/websocket_client.dart';
import 'package:client/src/channel.dart';
import 'package:client/src/messages/markdown.dart';
import 'package:client/src/agent.dart';
import 'package:client/src/messages/message.dart';
import 'package:client/src/messages/presenter.dart';

@Injectable()
class ImUniClient {
  TransportClient client;
  Agent currentAgent = new Agent.random();
  Channel selectedChannel;
  String messageText;

  ImUniClient() {
    WebSocket ws = new WebSocket('ws://localhost:8081');
    SimplePresenterFactory pFactory = new SimplePresenterFactory();
    ws
      ..onOpen
          .first
          .then((_) => _init(new WebSocketTransportClient(ws, pFactory)))
      ..onError.first.then((_) => _init(new LoopbackTransportClient(pFactory)));
  }

  void _init(TransportClient c) {
    client = c;

    // TODO: Implement channel persistence across server
    ['foo', 'bar', 'biz'].map(client.createChannel)..forEach(client.join);
    selectedChannel = client.channels.first;
  }

  void selectChannel(Channel c) {
    selectedChannel = c;
  }

  void sendMessage() {
    MarkdownMessage m = new MessageFactory(null).createMessage(messageText);
    m.author = currentAgent;
    client.send(selectedChannel, m);

    (querySelector("#messageInput") as InputElement).value = "";
  }
}

class MarkdownPresenter extends Presenter {
  MarkdownMessage message;

  MarkdownPresenter(this.message);

  present() {
    return "<markdown-message message='message'></message>";
  }
}

class SimplePresenterFactory extends PresenterFactory {
  Presenter getPresenter(Message m) {
    return new MarkdownPresenter(m);
  }
}

void main() {
  applicationFactory().rootContextType(ImUniClient).run();
}
