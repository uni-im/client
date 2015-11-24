import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'src/im_uni_client.dart';

class AnyUriPolicy implements UriPolicy {
  bool allowsUri(String uri) => true;
}

class UniImModule extends Module {
  UniImModule() {
    bind(NodeValidator, toFactory: () {
      final validator = new NodeValidatorBuilder.common()
        ..allowHtml5()
        ..allowImages(new AnyUriPolicy())
        ..allowNavigation(new AnyUriPolicy());

      return validator;
    });
  }
}

void main() {
  applicationFactory()
      .rootContextType(ImUniClient)
      .addModule(new UniImModule())
      .run();
}
