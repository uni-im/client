library test.transports.transport_atoms_test;

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:client/src/transports/transport_client.dart';

import '../utils/mocks.dart';
import 'package:client/src/messages/message.dart';
import 'package:client/src/channel.dart';

void main() {
  group('String to type function', () {
    group('atomTypeFromString', () {
      test('should return correct type for stringified value', () {
        AtomType.values.forEach((type) =>
            expect(atomTypeFromString(type.toString()), equals(type)));
      });

      test('should throw argument exception if not a valid string', () {
        expect(() => atomTypeFromString('badTypeString'), throwsArgumentError);
      });
    });
    group('controlTypeFromString', () {
      test('should return correct type for stringified value', () {
        ControlType.values.forEach((type) =>
            expect(controlTypeFromString(type.toString()), equals(type)));
      });

      test('should throw argument exception if not a valid string', () {
        expect(
            () => controlTypeFromString('badTypeString'), throwsArgumentError);
      });
    });
    group('agentCommandFromString', () {
      test('should return correct type for stringified value', () {
        AgentCommand.values.forEach((type) =>
            expect(agentCommandFromString(type.toString()), equals(type)));
      });

      test('should throw argument exception if not a valid string', () {
        expect(
            () => agentCommandFromString('badTypeString'), throwsArgumentError);
      });
    });
  });

  group('TransportAtomFactory', () {
    TransportAtomFactory transportAtomFactory;
    MessageFactory messageFactory = new MockMessageFactory();
    Message message = new MockMessage();
    Channel channel = new MockChannel();

    setUp(() {
      when(message.marshal()).thenReturn({'data': 'mock'});
      when(channel.title).thenReturn('title');

      transportAtomFactory = new TransportAtomFactory(messageFactory, []);
    });

    group('should return atom type of', () {
      test('MessageAtom when passed json payload', () {
        var messageAtom = new MessageAtom(message, channel);

        MessageAtom parseAtom =
            transportAtomFactory.fromJson(messageAtom.marshal());

        verify(messageFactory.fromJson({'data': 'mock'}));
        expect(parseAtom.channel.title, equals('title'));
      });

      group('ControlAtom when passed', () {
        test('json payload', () {
          var agent = new MockAgent();
          when(agent.name).thenReturn('sisyphus');

          var controlAtom = new AgentControlAtom(AgentCommand.joined, agent);

          AgentControlAtom parsedAtom =
              transportAtomFactory.fromJson(controlAtom.marshal());

          expect(parsedAtom.agent.name, equals('sisyphus'));
        });
      });
    });

    test('should throw exception when parsing unkown type', () {
      expect(
          () => transportAtomFactory
              .fromJson('{"type": "badType", "payload": "payload"}'),
          throwsArgumentError);
    });
  });
}
