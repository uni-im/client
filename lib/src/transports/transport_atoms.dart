part of client.src.transports.transport_client;

enum AtomType { message, control }

AtomType typeFromString(String type) =>
    AtomType.values.firstWhere((v) => v.toString() == type, orElse: () => null);

abstract class TransportAtom {
  final AtomType type;

  TransportAtom(this.type);

  String marshal({Map data}) {
    return JSON.encode({'type': type.toString(), 'payload': data});
  }
}

class MessageAtom extends TransportAtom {
  final Message message;
  final Channel channel;
  MessageAtom(this.message, this.channel) : super(AtomType.message);

  String marshal({Map data}) {
    return super.marshal(
        data: {'message': message.marshal(), 'channel': channel.title});
  }
}

class TransportAtomFactory {
  MessageFactory messageFactory;
  Iterable<Channel> channels;

  TransportAtomFactory(this.messageFactory, this.channels);

  TransportAtom fromJson(String json) {
    var blob = JSON.decode(json);
    var type = typeFromString(blob['type']);

    switch (type) {
      case AtomType.message:
        var message = messageFactory.fromJson(blob['data']['message']);
        var channel = channels.firstWhere(
            (c) => c.title == blob['data']['channel'],
            orElse: () => new GroupChannel(blob['data']['channel']));

        return new MessageAtom(message, channel);
      default:
        throw new ArgumentError.value('$type');
    }
  }
}
