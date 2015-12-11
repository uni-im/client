library test.agent_test;

import 'package:test/test.dart';
import 'package:client/src/agent.dart';

void main() {
  group('Agent', () {
    test('random factory should return a valid agent', () {
      var agent = new Agent.random();
      expect(agent.name, isNotEmpty);
    });
  });
}
