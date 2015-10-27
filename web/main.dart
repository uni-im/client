import 'package:client/client.dart';

void main() {
  var client = new MockClient();
  client.joinChannel(new Channel('Awesome Possum'));
  client.joinChannel(new Channel("Daffy Duck"));
}
