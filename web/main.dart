import 'package:angular/application_factory.dart';
import 'package:di/annotations.dart';
import 'package:client/client.dart';

@Injectable()
class ImUiClient {
  TransportClient client = new LoopbackTransportClient();
}

void main() {
  applicationFactory().rootContextType(ImUiClient).run();
}
