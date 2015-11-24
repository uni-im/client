part of client.src.transports.transport_client;

/// Provides a mock IO that immediately receives
class _Loopback {
  StreamController<_LoopbackContext> _loopStream = new StreamController();

  void submit(Channel c, Message m) =>
      _loopStream.add(new _LoopbackContext(c, m));

  Stream<_LoopbackContext> get incoming => _loopStream.stream;
}

/// A loopback data model used to collect messages and data into a immutable
/// type.
class _LoopbackContext {
  final Channel channel;
  final Message message;

  _LoopbackContext(this.channel, this.message);
}

/// Provides a short circuit transport that immediately receives any sent
/// messages.
class LoopbackTransportClient extends TransportClient {
  final _Loopback _loopback = new _Loopback();

  LoopbackTransportClient(PresenterFactory pFactory) : super(pFactory) {
    _loopback.incoming.listen(
        (context) => notifySubscribers(context.channel, context.message));
  }

  /// Sends the given message across the loopback client for a given channel.
  send(Channel c, Message m) => _loopback.submit(c, m);
}
