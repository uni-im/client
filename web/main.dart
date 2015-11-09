import 'package:angular/application_factory.dart';
import 'package:di/annotations.dart';
import 'package:client/client.dart';
import 'dart:html';
import 'package:client/src/transports/websocket_client.dart';
import 'package:client/src/channel.dart';
import 'package:client/src/messages/markdown.dart';


@Injectable()
class ImUniClient
{
  TransportClient client;
  Channel selectedChannel;
  String messageText;

  ImUniClient()
  {
    //TODO: fallback onError to loopback
    WebSocket socket = new WebSocket('ws://magic-man.benjica.com:8081');
    client = new WebSocketTransportClient(socket);
//    client=  new LoopbackTransportClient();

    ['foo', 'bar', 'biz', 'baz'].forEach(client.createChannel);
    client.channels.forEach(client.join);
    selectedChannel = client.channels.first;
  }

  void selectChannel(Channel c)
  {
    selectedChannel = c;
  }

  void sendMessage()
  {
    MarkdownMessage m = new MarkdownMessage(messageText);
    client.send(selectedChannel, m);
  }

}

void main()
{
  applicationFactory()
  .rootContextType(ImUniClient).run();
}
