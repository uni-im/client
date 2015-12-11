part of client.src.transports.transport_client;

/// A enumeration for the type of immutable atom
enum AtomType { message, control }

/// A helper function to return an [AtomType] for a given string
AtomType atomTypeFromString(String type) =>
    AtomType.values.firstWhere((v) => v.toString() == type,
        orElse: () => throw new ArgumentError.value(type));

/// An enumeration for the type of [ControlAtom]
enum ControlType { agent }

/// A helper function to return a [ControlType] for a given string
ControlType controlTypeFromString(String type) =>
    ControlType.values.firstWhere((v) => v.toString() == type,
        orElse: () => throw new ArgumentError.value(type));

/// An enumeration for the type of [AgentCommandAtom]
enum AgentCommand { joined, left }

/// A helper function to return an [AgentCommand] for a given string
AgentCommand agentCommandFromString(String type) =>
    AgentCommand.values.firstWhere((v) => v.toString() == type,
        orElse: () => throw new ArgumentError.value(type));

/// Provides base state for encapsulating transport mechansim for a given message
/// and implements the marshalling interface to covnvert the message state into
/// a JSON string for transport.
abstract class TransportAtom {
  final AtomType type;

  TransportAtom(this.type);

  /// Implements the marshalling interface to convert a given atom into a Json
  /// object for transporting across a network.
  String marshal({Map payload}) {
    return JSON.encode({'type': type.toString(), 'payload': payload});
  }
}

/// An extension of the [TransportAtom] that provides state for a given message
/// and implements the marshalling interface to covnvert the message state into
/// a JSON string for transport.
class MessageAtom extends TransportAtom {
  final Message message;
  final Channel channel;
  MessageAtom(this.message, this.channel) : super(AtomType.message);

  /// Implements the marshal interface allowing the atom to be serialized to
  /// the base [AtomTransport] serialization mechanism.
  String marshal({Map payload}) {
    return super.marshal(
        payload: {'message': message.marshal(), 'channel': channel.title});
  }

  /// Provides a string representation of the atom to provide human readable
  /// support. This is useful for serverside logging.
  String toString() {
    return "${message.author.name} sent a message on ${channel.title}";
  }
}

/// An extension of the [TransportAtom] that provides state for a given control
/// and implements the marshalling interface to covnvert the message state into
/// a JSON string for transport.
class ControlAtom extends TransportAtom {
  final ControlType control;
  ControlAtom(this.control) : super(AtomType.control);

  /// Implements the marshal interface allowing the atom to be serialized to
  /// the base [AtomTransport] serialization mechanism.
  String marshal({Map payload}) {
    return super.marshal(
        payload: {'control': control.toString(), 'parameters': payload});
  }
}

/// A specialized control atom which encapsulates state change for an agent
/// within the application.
class AgentControlAtom extends ControlAtom {
  final AgentCommand command;
  final Agent agent;
  Channel channel;
  AgentControlAtom(this.command, this.agent, {this.channel})
      : super(ControlType.agent);

  /// Implements the marshal interface allowing the atom to be serialized to
  /// the base [AtomTransport] serialization mechanism.
  String marshal({Map payload}) {
    return super.marshal(payload: {
      'command': command.toString(),
      'agent': agent.name,
      'channel': channel?.title
    });
  }

  /// Provides a string representation of the atom to provide human readable
  /// support. This is useful for serverside logging.
  String toString() {
    return "${agent.name} $command ${channel.title}";
  }
}

/// Provides a factory object that can unseralize [TransportAtom]s into application
/// objects. A [TransportClient] can use this factory object to pass serialized
/// state objects recieved via a connection and get instances of objects related
/// to them.
class TransportAtomFactory {
  /// A message factory capable of standing up new messages.
  MessageFactory messageFactory;

  /// The collection of current channels
  Iterable<Channel> channels;

  TransportAtomFactory(this.messageFactory, this.channels);

  /// The deserialization function called by [TransportClient]s to get an
  /// immutable object that represents the serialized data it recieves.
  TransportAtom fromJson(String json) {
    var blob = JSON.decode(json);
    var type = atomTypeFromString(blob['type']);
    var payload = blob['payload'];

    // Each type of [AtomType] is constructed
    switch (type) {
      case AtomType.message:
        // parse message data and create [MessageAtom]
        var message = messageFactory.fromJson(payload['message']);
        var channel = channels.firstWhere((c) => c.title == payload['channel'],
            orElse: () => new GroupChannel(payload['channel']));

        return new MessageAtom(message, channel);
      case AtomType.control:
        // parse control data and create [ControlAtom] based on control type
        var controlType = controlTypeFromString(payload['control']);
        var params = payload['parameters'];

        switch (controlType) {
          case ControlType.agent:
            // Agent commands are interpreted and used to create an
            // [AgentCommandAtom]
            var command = agentCommandFromString(params['command']);
            var agent = new Agent(params['agent']);
            var channel = channels.firstWhere(
                (c) => c.title == params['channel'],
                orElse: () => new GroupChannel(params['channel']));

            return new AgentControlAtom(command, agent, channel: channel);
          default:
            throw new ArgumentError.value(controlType);
        }

        break;

      default:
        // The factory throws an exception on bad serialized state
        throw new ArgumentError.value('$type');
    }
  }
}
