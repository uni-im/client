library client.src.transports.websocket_client;

import 'dart:html';

import 'package:client/src/agent.dart';
import 'package:client/src/channel.dart';
import 'package:client/src/messages/message.dart';
import 'package:client/src/messages/presenter.dart';
import 'package:client/src/transports/transport_client.dart';

/// A concrete implementation of a [TransportClient] that facilitates message
/// communication via a WebSocket through the [TransprotClient] interface. This
/// insulates the consumer from the serialization and tranpsort messaging while
/// receiving notify calls as observers to the subject.
class WebSocketTransportClient extends TransportClient {
  /// The backing websocket connection for the transport
  WebSocket _webSocket;

  /// The factory mechanism for inflating atoms received over the websocket
  /// connection.
  TransportAtomFactory _atomFactory;

  /// Consumers of the websocket provide the current agent, a web socket, and
  /// presentation factory.
  WebSocketTransportClient(WebSocket ws, Agent agent, PresenterFactory pFactory)
      : super(agent, pFactory) {
    // Caputer the injected websocket and listen to new data events.
    _webSocket = ws;
    _webSocket.onMessage.listen(_handleMessage);

    // Instantiate the atom factory with the required dependencies
    _atomFactory = new TransportAtomFactory(messageFactory, subscriptions);
  }

  @override
  bool join(Channel c) {
    if (super.join(c)) {
      // If this is a new subscription send a control message to the backend
      // to let other users know the user has joined the channel.
      var atom = new AgentControlAtom(AgentCommand.joined, agent, channel: c);
      _webSocket.send(atom.marshal());

      return true;
    }

    return false;
  }

  @override
  bool leave(Channel c) {
    var left = super.leave(c);

    // Send a control atom letting the backend know the agent has unsubscriped
    // from the channel.
    _webSocket.send(
        new AgentControlAtom(AgentCommand.left, agent, channel: c).marshal());

    return left;
  }

  void send(Channel c, Message m) {
    // Create a new Message Atom and propegate it to the backend service.
    var atom = new MessageAtom(m, c);
    _webSocket.send(atom.marshal());
  }

  void _handleMessage(MessageEvent e) {
    // Deserialze the data
    var atom = _atomFactory.fromJson(e.data);

    if (atom is MessageAtom) {
      // MessageAtoms are sent to observers directly
      notifySubscribers(atom.channel, atom.message);
    } else if (atom is AgentControlAtom) {
      // ControlAtoms are intepreted and a transient control message is created
      // and submitted to the appropriate channel
      var verb = atom.command == AgentCommand.joined ? 'joined' : 'left';
      notifySubscribers(
          atom.channel,
          messageFactory
              .createControlMessage('${atom.agent.name} $verb the channel'));
    }
  }
}
