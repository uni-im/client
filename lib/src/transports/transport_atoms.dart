part of client.src.transports.transport_client;

enum AtomType { message, control }

AtomType atomTypeFromString(String type) =>
    AtomType.values.firstWhere((v) => v.toString() == type,
        orElse: () => throw new ArgumentError.value(type));

abstract class TransportAtom {
  final AtomType type;

  TransportAtom(this.type);

  String marshal({Map payload}) {
    return JSON.encode({'type': type.toString(), 'payload': payload});
  }
}

class MessageAtom extends TransportAtom {
  final Message message;
  final Channel channel;
  MessageAtom(this.message, this.channel) : super(AtomType.message);

  String marshal({Map payload}) {
    return super.marshal(
        payload: {'message': message.marshal(), 'channel': channel.title});
  }

  String toString() {
    return "${message.author.name} sent a message on ${channel.title}";
  }
}

enum ControlType { agent }
ControlType controlTypeFromString(String type) =>
    ControlType.values.firstWhere((v) => v.toString() == type,
        orElse: () => throw new ArgumentError.value(type));

class ControlAtom extends TransportAtom {
  final ControlType control;
  ControlAtom(this.control) : super(AtomType.control);

  String marshal({Map payload}) {
    return super.marshal(
        payload: {'control': control.toString(), 'parameters': payload});
  }
}

enum AgentCommand { joined, left }

AgentCommand agentCommandFromString(String type) =>
    AgentCommand.values.firstWhere((v) => v.toString() == type,
        orElse: () => throw new ArgumentError.value(type));

class AgentControlAtom extends ControlAtom {
  final AgentCommand command;
  final Agent agent;
  Channel channel;
  AgentControlAtom(this.command, this.agent, {this.channel})
      : super(ControlType.agent);

  String marshal({Map payload}) {
    return super.marshal(payload: {
      'command': command.toString(),
      'agent': agent.name,
      'channel': channel?.title
    });
  }

  String toString() {
    return "${agent.name} $command ${channel.title}";
  }
}

class TransportAtomFactory {
  MessageFactory messageFactory;
  Iterable<Channel> channels;

  TransportAtomFactory(this.messageFactory, this.channels);

  TransportAtom fromJson(String json) {
    var blob = JSON.decode(json);
    var type = atomTypeFromString(blob['type']);
    var payload = blob['payload'];

    switch (type) {
      case AtomType.message:
        var message = messageFactory.fromJson(payload['message']);
        var channel = channels.firstWhere((c) => c.title == payload['channel'],
            orElse: () => new GroupChannel(payload['channel']));

        return new MessageAtom(message, channel);
      case AtomType.control:
        var controlType = controlTypeFromString(payload['control']);
        var params = payload['parameters'];

        switch (controlType) {
          case ControlType.agent:
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
        throw new ArgumentError.value('$type');
    }
  }
}
