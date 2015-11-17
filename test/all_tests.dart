import 'package:test/test.dart';

import 'messages/markdown_test.dart' as markdown_tests;
import 'messages/message_test.dart' as message_tests;
import 'transports/transport_client_test.dart' as transport_client_tests;
import 'channel_test.dart' as channel_tests;

void main() {
  group('', channel_tests.main);
  group('', markdown_tests.main);
  group('', message_tests.main);
  group('', transport_client_tests.main);
}
