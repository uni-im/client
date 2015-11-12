library test.messages.message_test;

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import '../utils/mocks.dart';
import 'package:client/src/presenters/message_presenter_factory.dart';
import 'package:client/src/presenters/message_preseneter.dart';
import 'package:client/src/messages/message.dart';

void main() {
  group('Message Presenter Factory', () {
    Message message;
    MessagePresenter presenter;

    setUp(() {});

    test('should throw exception on invalid message type', () {
      expect(() => MessagePresenterFactory.getPresenter(null),
          throwsA(new isInstanceOf<Exception>()));
    });

    test('should get markdown presenter', () {
      message = new MockMarkdownMessage();
      presenter = MessagePresenterFactory.getPresenter(message);
      expect(presenter, new isInstanceOf<MarkdownMessagePresenter>());
    });

    test('should get link presenter', () {
      message = new MockLink();
      presenter = MessagePresenterFactory.getPresenter(message);
      expect(presenter, new isInstanceOf<LinkPresenter>());
    });

    test('should get file presenter', () {
      message = new MockFile();
      presenter = MessagePresenterFactory.getPresenter(message);
      expect(presenter, new isInstanceOf<FilePresenter>());
    });

    test('should get image presenter', () {
      message = new MockImage();
      presenter = MessagePresenterFactory.getPresenter(message);
      expect(presenter, new isInstanceOf<ImagePresenter>());
    });
  });
}
