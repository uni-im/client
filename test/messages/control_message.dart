library test.messages.control_message_test;

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:client/src/messages/control.dart';
import 'package:client/src/messages/message.dart';
import '../utils/mocks.dart';
import 'package:client/src/messages/presenter.dart';

void main() {
  group('ControlMessage', () {
    MessageFactory messageFactory;
    Presenter presenter;

    setUp(() {
      presenter = new MockPresenter();
      var mockPresenterFactory = new MockPresenterFactory();

      when(mockPresenterFactory.getPresenter(any)).thenReturn(presenter);
      messageFactory = new MessageFactory(mockPresenterFactory);
    });

    test('should marshal to empty map', () {
      var message = messageFactory.controlMessage('test message');
      expect(message.marshal(), equals({}));
      expect(message.render(), equals('test message'));
      verify(presenter.present()).called(1);
    });
  });
}
