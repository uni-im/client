library test.messages.file_message_test;

import 'package:client/src/agent.dart';
import 'package:client/src/messages/message.dart';
import 'package:test/test.dart';

void main() {
  final Uri uri = Uri.parse('http://localhost/');
  group('FileMessageFactory', () {
    FileMessageFactory fileMessageFactory;
    setUp(() {
      fileMessageFactory = new FileMessageFactory();
    });
    group('returns correct class type for', () {
      test('image content type', () {
        var contentType = 'image/png';
        var message = fileMessageFactory.createFileMessage(uri, contentType);
        expect(message, new isInstanceOf<Image>());
      });
      test('video content type', () {
        var contentType = 'video/webm';
        var message = fileMessageFactory.createFileMessage(uri, contentType);
        expect(message, new isInstanceOf<Video>());
      });
      test('default content type', () {
        var contentType = 'text/html';
        var message = fileMessageFactory.createFileMessage(uri, contentType);
        expect(message, new isInstanceOf<FileMessage>());
      });
    });
  });

  group('FileMessage', () {
    test('should marshal a valid json string', () {
      var message = new FileMessage(uri, 'text/html');
      message.author = new Agent('mock user');
      var map = message.marshal();

      expect(map['type'], equals(('file')));
      expect(map['author'], equals('mock user'));
      expect(map['uri'], equals(uri.toString()));
      expect(map['content-type'], equals('text/html'));
    });
  });
}

class MockAuthor {}
