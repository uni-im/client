library client.test.utils.mocks;

import 'package:mockito/mockito.dart';
import 'package:client/src/channel.dart';
import 'package:client/src/messages/message.dart';
import 'package:client/src/messages/link.dart';
import 'package:client/src/messages/markdown.dart';
import 'package:client/src/messages/file.dart';

class MockChannel extends Mock implements Channel {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockMessage extends Mock implements Message {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockLink extends Mock implements Link {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockMarkdownMessage extends Mock implements MarkdownMessage {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockFile extends Mock implements File {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockImage extends Mock implements Image {
  noSuchMethod(i) => super.noSuchMethod(i);
}
