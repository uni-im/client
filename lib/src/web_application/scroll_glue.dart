library client.src.web_application.scroll_glue;

import 'package:angular/angular.dart';
import 'dart:html';

@Decorator(selector: 'glue')
class ScrollGlue {
  Element el;
  bool attached = false;
  Scope scope;

  ScrollGlue(this.el, this.scope);

  attach() {
    ReactionFn scrollIfGlued = (prev, next) {
      if (attached) {
        scroll();
      }
    };

    el.onScroll.listen(_onScroll);
    scope.watch("", scrollIfGlued);
  }

  bool get isAttached => el.clientHeight + el.scrollTop + 1 >= el.scrollHeight;

  scroll() {
    el.scrollTop = el.scrollHeight;
  }

  _onScroll(Event e) {
    attached = isAttached;
  }
}
