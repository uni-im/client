library test.messages.message_test;

import 'package:test/test.dart';
import 'package:client/src/messages/message.dart';
import 'package:client/src/messages/markdown.dart';

void main() {
  group('Message', () {
    group('factory function', () {
      test('should throw ArgumentError if type is missing from map', () {
        expect(() => new Message.unmarshal({}), throwsArgumentError);
      });

      test('should return MarkdownMessage type', () {
        var data = {'type': 'markdown'};
        var message = new Message.unmarshal(data);

        expect(message, new isInstanceOf<MarkdownMessage>());
      });

      test('should throw exception when type field of JSON is null', () {
        expect(() => new Message.unmarshal({'data': {}}), throwsArgumentError);
      });
    });
  });
}
