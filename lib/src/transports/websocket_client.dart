library client.src.transports.websocket_client;

import 'dart:html';

import 'package:client/src/agent.dart';
import 'package:client/src/channel.dart';
import 'package:client/src/messages/message.dart';
import 'package:client/src/messages/presenter.dart';
import 'package:client/src/transports/transport_client.dart';

class WebSocketTransportClient extends TransportClient {
  WebSocket _webSocket;
  TransportAtomFactory _atomFactory;

  WebSocketTransportClient(WebSocket ws, Agent agent, PresenterFactory pFactory)
      : super(agent, pFactory) {
    _webSocket = ws;
    _webSocket.onMessage.listen(_handleMessage);
    _atomFactory = new TransportAtomFactory(messageFactory, subscriptions);
  }

  @override
  bool join(Channel c) {
    if (super.join(c)) {
      var atom = new AgentControlAtom(AgentCommand.joined, agent, channel: c);
      _webSocket.send(atom.marshal());

      return true;
    }

    return false;
  }

  @override
  bool leave(Channel c) {
    var left = super.leave(c);

    _webSocket.send(
        new AgentControlAtom(AgentCommand.left, agent, channel: c).marshal());

    return left;
  }

  void send(Channel c, Message m) {
    var atom = new MessageAtom(m, c);
    _webSocket.send(atom.marshal());
  }

  void _handleMessage(MessageEvent e) {
    var atom = _atomFactory.fromJson(e.data);

    if (atom is MessageAtom) {
      notifySubscribers(atom.channel, atom.message);
    } else if (atom is AgentControlAtom) {
      var verb = atom.command == AgentCommand.joined ? 'joined' : 'left';
      notifySubscribers(
          atom.channel,
          messageFactory
              .controlMessage('${atom.agent.name} $verb the channel'));
    }
  }
}
