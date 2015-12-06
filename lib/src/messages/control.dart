part of client.src.messages.message;

class ControlMessage extends Message {
  String body;
  final bool isControl = true;
  bool viewed = true;

  ControlMessage(this.body);

  @override
  Map marshal() => {};
}
