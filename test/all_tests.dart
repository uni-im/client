import 'package:test/test.dart';

import 'agent_test.dart' as agent_tests;
import 'messages/markdown_test.dart' as markdown_tests;
import 'messages/message_test.dart' as message_tests;
import 'transports/loopback_client_test.dart' as loopback_transport_tests;
import 'transports/transport_client_test.dart' as transport_client_tests;
import 'channel_test.dart' as channel_tests;

void main() {
  group('', agent_tests.main);
  group('', channel_tests.main);
  group('', markdown_tests.main);
  group('', message_tests.main);
  group('', loopback_transport_tests.main);
  group('', transport_client_tests.main);
}
