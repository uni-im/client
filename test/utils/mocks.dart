library client.test.utils.mocks;

import 'package:mockito/mockito.dart';

import 'package:client/src/channel.dart';
import 'package:client/src/messages/message.dart';
import 'package:client/src/messages/presenter.dart';

class MockChannel extends Mock implements Channel {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockMessage extends Mock implements Message {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockPresenter extends Mock implements Presenter {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockPresenterFactory extends Mock implements PresenterFactory {
  noSuchMethod(i) => super.noSuchMethod(i);
}
