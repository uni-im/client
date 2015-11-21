library test.messages.message_test;

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

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

      group('with presenter factory', () {
        const messageData = const {'type': 'markdown'};
        var presenter = new MockPresenter();
        var presenterFactory = new MockPresenterFactory();
        MessageFactory messageFactory;

        setUp(() {
          when(presenterFactory.getPresenter(any)).thenReturn(presenter);
          messageFactory = new MessageFactory(presenterFactory);
        });

        test('should return MarkdownMessage type from valid json blob', () {
          var message = messageFactory.fromJson(messageData);
          expect(message, new isInstanceOf<MarkdownMessage>());
        });

        test('should return message with presenter returned from factory', () {
          var message = messageFactory.createMessage('test message');

          expect(message.presenter, same(presenter));
        });

        test('should call presenter present call on render', () async {
          var message = messageFactory.fromJson(messageData);
          await message.render();

          verify(presenter.present());
        });

        test('should throw exception when type field of JSON is null', () {
          expect(() => messageFactory.fromJson({}), throwsArgumentError);
        });
      });
    });
  });
}
