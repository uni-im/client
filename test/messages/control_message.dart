library test.messages.control_message_test;

import 'package:client/src/messages/message.dart';
import 'package:client/src/messages/presenter.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../utils/mocks.dart';

void main() {
  group('ControlMessage', () {
    MessageFactory messageFactory;
    Presenter presenter;

    setUp(() {
      presenter = new MockPresenter();
      var mockPresenterFactory = new MockPresenterFactory();

      when(mockPresenterFactory.getPresenter(any)).thenReturn(presenter);
      when(presenter.present()).thenReturn('test message');
      messageFactory = new MessageFactory(mockPresenterFactory);
    });

    test('should marshal to empty map', () {
      var message = messageFactory.controlMessage('test message');
      expect(message.marshal(), equals({}));
    });

    test('should render presenter output', () {
      var message = messageFactory.controlMessage('test message');
      expect(message.render(), equals('test message'));
      verify(presenter.present()).called(1);
    });
  });
}
