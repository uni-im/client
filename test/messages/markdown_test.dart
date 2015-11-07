library test.messages.markdown_test;
import 'package:test/test.dart';
import 'package:client/src/messages/markdown.dart';

void main() {
  group('MarkdownMessage', () {
    test('marshal should build json', () {
      const messageText = 'test body';
      var message = new MarkdownMessage(messageText);
      var map = message.marshal();

      expect(map['type'], equals(('markdown')));
      expect(map['body'], equals(messageText));
    });
  });
}