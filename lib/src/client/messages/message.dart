library client.src.client.messages.message;

abstract class Message {
  dynamic render();
}

class TextMessage extends Message {
  String message;
  DateTime timestamp = new DateTime.now();

  TextMessage(this.message);

  dynamic render() {
    return message;
  }
}
