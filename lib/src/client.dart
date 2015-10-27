library client.src.client;

import 'dart:async';

class Channel {
  final String name;

  Channel(this.name);

  void notify(Message m) => print("$name: $m");
}

class Message {
  String body;
  String thread;

  Message(this.thread, this.body);

  String toString() => body;
}

abstract class Client {
  Set<Channel> subscriptions = new Set<Channel>();

  void joinChannel(Channel c) => subscriptions.add(c);

  void leaveChannel(Channel c) => subscriptions.remove(c);

  void notify(Message m) => subscriptions
      .where((c) => m.thread == c.name)
      .forEach((c) => c.notify(m));
}

class TimerClient extends Client {
  TimerClient() {
    var a = new Timer.periodic(const Duration(seconds: 1),
        (_) => notify(new Message('Awesome Possum', 'Hello world!')));
    var b = new Timer.periodic(const Duration(seconds: 2),
        (_) => notify(new Message('Daffy Duck', 'Goodbye, world!')));
  }
}
