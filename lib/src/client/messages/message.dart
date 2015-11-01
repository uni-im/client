library client.src.client.messages.message;

abstract class Message {
  dynamic render();
}

class TextMessage extends Message {
  String message;

  TextMessage(this.message);

  dynamic render() {
    return message;
  }
}
