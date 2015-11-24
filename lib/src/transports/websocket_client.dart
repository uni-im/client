library client.src.transports.websocket_client;

import 'dart:html';

import 'package:client/src/channel.dart';
import 'package:client/src/messages/message.dart';
import 'package:client/src/transports/transport_client.dart';
import 'package:client/src/messages/presenter.dart';

class WebSocketTransportClient extends TransportClient {
  WebSocket _webSocket;
  TransportAtomFactory _atomFactory;

  WebSocketTransportClient(WebSocket ws, PresenterFactory pFactory)
      : super(pFactory) {
    _webSocket = ws;
    _webSocket.onMessage.listen(_handleMessage);
    _atomFactory = new TransportAtomFactory(messageFactory, subscriptions);
  }

  void send(Channel c, Message m) {
    var atom = new MessageAtom(m, c);
    _webSocket.send(atom.marshal());
  }

  void _handleMessage(MessageEvent e) {
    var atom = _atomFactory.fromJson(e.data);
    notifySubscribers(atom.channel, atom.message);
  }
}
