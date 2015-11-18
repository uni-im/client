library test.messages.message_test;

import 'package:test/test.dart';
import 'package:client/src/messages/message.dart';
import 'package:client/src/messages/markdown.dart';

import '../utils/mocks.dart';

void main() {
  group('Message', () {
    group('factory function', () {
      test('should throw ArgumentError if type is missing from map', () {
        expect(
            () => new MessageFactory(new MockPresenterFactory()).fromJson({}),
            throwsArgumentError);
      });

      test('should return MarkdownMessage type', () {
        var data = {'type': 'markdown'};
        var message =
            new MessageFactory(new MockPresenterFactory()).fromJson(data);

        expect(message, new isInstanceOf<MarkdownMessage>());
      });

      test('should throw exception when type field of JSON is null', () {
        expect(
            () => new MessageFactory(new MockPresenterFactory())
                .fromJson({'data': {}}),
            throwsArgumentError);
      });
    });
  });
}
