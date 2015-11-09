import 'package:angular/application_factory.dart';
import 'package:di/annotations.dart';
import 'package:client/client.dart';
import 'dart:html';
import 'package:client/src/transports/websocket_client.dart';
import 'package:client/src/channel.dart';
import 'package:client/src/messages/markdown.dart';

@Injectable()
class ImUniClient {
  TransportClient client;
  Channel selectedChannel;
  String messageText;

  ImUniClient() {
    WebSocket ws = new WebSocket('ws://magic-man.benjica.com:8081');
    ws
      ..onOpen.first.then((_) => _init(new WebSocketTransportClient(ws)))
      ..onError.first.then((_) => _init(new LoopbackTransportClient()));
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
    MarkdownMessage m = new MarkdownMessage(messageText);
    client.send(selectedChannel, m);
  }
}

void main() {
  applicationFactory().rootContextType(ImUniClient).run();
}
