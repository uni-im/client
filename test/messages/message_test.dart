library test.messages.message_test;

import 'package:client/src/messages/message.dart';
import 'package:client/src/messages/presenter.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../utils/mocks.dart';

void main() {
  group('MessageFactory', () {
    const presenterReturn = 'test present';
    Presenter presenter = new MockPresenter();
    PresenterFactory presenterFactory = new MockPresenterFactory();
    MessageFactory messageFactory;

    setUp(() {
      when(presenterFactory.getPresenter(any)).thenReturn(presenter);
      when(presenter.present()).thenReturn(presenterReturn);
      messageFactory = new MessageFactory(presenterFactory);
    });

    test('should throw ArgumentError if type is missing from map', () {
      expect(() => messageFactory.fromJson({}), throwsArgumentError);
    });

    group('with MarkdownMessage', () {
      const messageBlob = const {'type': 'markdown', 'payload': const {}};
      test('should return from valid json blob', () {
        var message = messageFactory.fromJson(messageBlob);
        expect(message, new isInstanceOf<MarkdownMessage>());
      });

      test('should return message with presenter from factory', () {
        var message = messageFactory.createMessage('test message');
        expect(message.presenter, same(presenter));
      });

      test('should call presenter present on render', () {
        var message = messageFactory.createMessage('test message');
        expect(message.render(), equals(presenterReturn));
        verify(presenter.present()).called(1);
      });
    });

    group('with FileMessage', () {
      const messageBlob = const {
        'type': 'file',
        'uri': 'http://localhost',
        'content-type': 'text/text'
      };

      test('should return type from vaild json blob', () {
        var message = messageFactory.fromJson(messageBlob);
        expect(message, new isInstanceOf<FileMessage>());
      });

      test('should return message with presenter returned from factory', () {
        var uri = Uri.parse("http://localhost:1234");
        var contentType = 'text/text';
        var message = messageFactory.createFileMessage(uri, contentType);

        expect(message.presenter, same(presenter));
      });
    });

    group('ControlMessage', () {
      test('should return message with presenter from factory', () {
        var message = messageFactory.controlMessage('test message');
        expect(message.presenter, same(presenter));
      });
    });
  });
}
