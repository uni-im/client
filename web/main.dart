import 'package:angular/application_factory.dart';
import 'package:di/annotations.dart';
import 'package:client/client.dart';
import 'package:client/src/client/messages/message.dart';
import 'package:angular/angular.dart';

@Injectable()
class ImUiClient {
  TransportClient client = new LoopbackTransportClient();
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
