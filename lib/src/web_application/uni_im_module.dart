library client.src.web_application.uni_im_module;

import 'dart:html';

import 'package:angular/angular.dart';

/// A [UriPolicy] that allows any url to be used within the templating engine
/// in Angular Dart.
class AnyUriPolicy implements UriPolicy {
  bool allowsUri(String uri) => true;
}

/// A collection of type overrides used by Angular Dart within the web
/// application. This specifcally allows the injection of dom elements relevent
/// to the [Presentation] classes.
class UniImModule extends Module {
  UniImModule() {
    // When Angular needs a NodeValdiator it calls the given factory function
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
