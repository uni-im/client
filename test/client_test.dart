library test.client_test;

import 'package:client/src/client.dart';
import 'package:test/test.dart';

void main() {
  group('Awesome', () {
    test('should always be awesome', () {
      Awesome awesome = new Awesome();

      expect(awesome.isAwesome, isTrue);
    });
  });
}
