part of client.src.transports.transport_client;

class LoopbackTransportClient extends TransportClient {
  void send(Channel c, Message m) => notifySubscribers(c, m);
}
