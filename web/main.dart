import 'package:angular/application_factory.dart';
import 'package:client/web_application.dart';

void main() {
  applicationFactory()
      .rootContextType(ImUniClient)
      .addModule(new UniImModule())
      .run();
}
