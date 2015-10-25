import 'dart:html';

import 'package:client/client.dart';

void main() {
  Awesome you = new Awesome();

  querySelector('#output').text =
      you.isAwesome ? 'You awesome!' : 'You could be awesome';
}
