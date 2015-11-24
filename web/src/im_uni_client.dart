library web.src.im_application;

import 'package:client/src/transports/transport_client.dart';
import 'package:client/src/agent.dart';
import 'package:client/src/channel.dart';
import 'dart:html';
import 'package:client/src/transports/websocket_client.dart';
import 'package:client/src/messages/markdown.dart';
import 'package:client/src/messages/presenter.dart';
import 'package:markdown/markdown.dart';
import 'package:client/src/messages/message.dart';
import 'package:angular/angular.dart';

class MarkdownPresenter extends Presenter {
  MarkdownMessage message;

  MarkdownPresenter(this.message);

  present() {
    return markdownToHtml(message.body);
  }
}

class SimplePresenterFactory extends PresenterFactory {
  Presenter getPresenter(Message m) {
    return new MarkdownPresenter(m);
  }
}

@Injectable()
class ImUniClient {
  TransportClient client;
  Agent currentAgent = new Agent.random();
  Channel selectedChannel;
  String messageText;

  ImUniClient() {
    WebSocket ws = new WebSocket('ws://magic-man.benjica.com:8081');
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
