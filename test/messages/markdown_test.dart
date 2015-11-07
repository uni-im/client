library test.messages.markdown_test;
import 'package:test/test.dart';
import 'package:client/src/messages/markdown.dart';

void main() {
  group('MarkdownMessage', () {
    const messageText = 'test body';
    test('marshal should build a valid json string', () {
      var message = new MarkdownMessage(messageText);
      var map = message.marshal();

      expect(map['type'], equals(('markdown')));
      expect(map['body'], equals(messageText));
    });

    test('factory should return expected values from map', () {
      var message = new MarkdownMessage.fromMap({'body': messageText});
      expect(message.body, equals(messageText));
    });
  });
}