part of client.src.messages.message;

class ControlMessage extends Message {
  String body;
  final bool isControl = true;

  ControlMessage(this.body);

  dynamic render() => presenter.present();

  @override
  Map marshal() => {};
}
