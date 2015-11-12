library test.messages.message_test;
import 'package:test/test.dart';
import 'package:client/src/presenters/message_preseneter.dart';
import '../utils/mocks.dart';
import 'package:client/src/messages/link.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('Message Presenter', () {

    LinkPresenter presenter;
    MockLink message;

    setUp(() {
      presenter = new LinkPresenter();
      message = new MockLink();
      when(message.getTitle()).thenReturn('Example Domain');
      when(message.getRef()).thenReturn('http://example.com');
    });

    test('should generate valid html link', () {
      expect(presenter.presentHTML(message),
          equals('<a href="http://example.com">Example Domain</a>'));
    });

    test('should generate valid markdown link', () {
      expect(presenter.presentMarkdown(message),
          equals('[Example Domain](http://example.com)'));
    });

    test('should generage plain text link', () {
      expect(presenter.presentPlaintext(message),
          equals('Example Domain\t-\thttp://example.com'));
    });

  });
}