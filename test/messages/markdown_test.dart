library test.messages.markdown_test;

import 'package:test/test.dart';
import 'package:client/src/messages/markdown.dart';
import 'package:client/src/agent.dart';
import '../utils/mocks.dart';

void main() {
  group('MarkdownMessage', () {
    const messageText = 'test body';
    test('marshal should build a valid json string', () {
      var message = new MarkdownMessage(messageText);
      message.author = new Agent('mock user');
      var map = message.marshal();

      expect(map['type'], equals(('markdown')));
      expect(map['author'], equals('mock user'));
      expect(map['body'], equals(messageText));
    });

    test('factory should return expected values from map', () {
      var message = new MarkdownMessage.fromMap({'body': messageText});
      expect(message.body, equals(messageText));
    });

    test('should handle child messages', () {
      var message = new MarkdownMessage(messageText);
      var childMessage = new MockMessage();
      message.add(childMessage);

      expect(message.children, contains(childMessage));

      message.remove(childMessage);
      expect(message.children, isNot(contains(childMessage)));
    });
  });
}
