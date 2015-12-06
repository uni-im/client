library client.src.web_application.uni_im_module;

import 'dart:html';

import 'package:angular/angular.dart';

import 'package:client/src/web_application/scroll_glue.dart';

class AnyUriPolicy implements UriPolicy {
  bool allowsUri(String uri) => true;
}

class UniImModule extends Module {
  UniImModule() {
    bind(ScrollGlue);
    bind(NodeValidator, toFactory: () {
      final validator = new NodeValidatorBuilder.common()
        ..allowHtml5()
        ..allowElement('video', attributes: ['src'])
        ..allowElement('source', attributes: ['src', 'type'])
        ..allowImages(new AnyUriPolicy())
        ..allowNavigation(new AnyUriPolicy());

      return validator;
    });
  }
}
