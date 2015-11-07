
import 'package:angular/application_factory.dart';
import 'package:di/annotations.dart';
import 'package:angular/angular.dart';

import 'package:client/src/client/channel.dart';
import 'package:client/src/client/messages/message.dart';
import 'package:client/src/client/transports/websocket_transport_client.dart';
import 'package:client/src/client/transports/transport_client.dart';

@Injectable()
class ImUiClient {
  TransportClient client = new WebSocketTransportClient();
  Channel selectedChannel;
  String messageBody = '';

  ImUiClient() {
    selectedChannel = client.channels.first;
  }

  void selectChannel(Channel c) {
    selectedChannel = c;
  }

  void sendMessage() {
    client.send(selectedChannel, new TextMessage(messageBody));
  }
}

@Component(selector: 'message', templateUrl: 'message.html')
class MessageComponent {
  @NgOneWay('model')
  Message model;
}

class ImUIClientModule extends Module {
  ImUIClientModule() {
    bind(MessageComponent);
  }
}

void main() {
  applicationFactory()
      .rootContextType(ImUiClient)
      .addModule(new ImUIClientModule())
      .run();
}
