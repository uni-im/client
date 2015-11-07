library client.src.client.transports.websocket_transport_client;

import 'dart:html';

import 'package:client/src/client/channel.dart';
import 'package:client/src/client/messages/message.dart';
import 'package:client/src/client/transports/transport_client.dart';

class WebSocketTransportClient extends TransportClient {
  WebSocket _websocket = new WebSocket("ws://localhost:8080");
  WebSocketTransportClient() {
    createChannel("Main Channel");
    channels.forEach(join);

    _websocket.onMessage.listen(_handleMessage);
  }

  void send(Channel c, Message m) {
    if (m is TextMessage) {
      _websocket.sendString("${m.message}");
    }
  }

  void _handleMessage(MessageEvent e) {
    notifySubscribers(channels.first, new TextMessage(e.data as String));
  }
}
