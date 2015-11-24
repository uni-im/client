library client.src.transports.websocket_client;

import 'dart:html';
import 'dart:convert';

import 'package:client/src/channel.dart';
import 'package:client/src/messages/message.dart';
import 'package:client/src/transports/transport_client.dart';
import 'package:client/src/messages/presenter.dart';

class _WebSocketTransportContext {
  final Channel channel;
  final Map message;

  _WebSocketTransportContext(this.channel, this.message);

  factory _WebSocketTransportContext.fromJson(
      Iterable<Channel> channels, String json) {
    var map = JSON.decode(json);

    var channel = channels.firstWhere((c) => c.title == map['channel'],
        orElse: () => new GroupChannel(map['channel']));

    return new _WebSocketTransportContext(channel, map['data']);
  }

  String toJson() {
    var map = new Map();

    map['channel'] = channel.title;
    map['data'] = message;

    return JSON.encode(map);
  }
}

class WebSocketTransportClient extends TransportClient {
  WebSocket _webSocket;

  WebSocketTransportClient(WebSocket ws, PresenterFactory pFactory)
      : super(pFactory) {
    _webSocket = ws;
    _webSocket.onMessage.listen(_handleMessage);
  }

  void send(Channel c, Message m) {
    var context = new _WebSocketTransportContext(c, m.marshal());
    _webSocket.send(context.toJson());
  }

  void _handleMessage(MessageEvent e) {
    var context =
        new _WebSocketTransportContext.fromJson(subscriptions, e.data);
    var message = messageFactory.fromJson(context.message);

    notifySubscribers(context.channel, message);
  }
}
