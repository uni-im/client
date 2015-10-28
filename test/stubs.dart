import 'package:client/src/channel.dart';
import 'package:client/src/message.dart';

class StubChannel implements Channel {
  @override
  bool notified = false;
  Message notifyMessage;

  void notify(Message m) {
    notified = true;
    notifyMessage = m;
  }
}
