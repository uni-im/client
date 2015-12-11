import 'package:angular/application_factory.dart';
import 'package:client/web_application.dart';

void main() {
  // Create a new Angular Dart application
  applicationFactory()
      .rootContextType(UniImClientFacade)
      .addModule(new UniImModule())
      .run();
}
