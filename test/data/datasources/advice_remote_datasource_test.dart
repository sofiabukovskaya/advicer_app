import 'package:advicer_app/data/datasources/advice_remote_datasource.dart';
import 'package:advicer_app/data/exceptions/exceptions.dart';
import 'package:advicer_app/data/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group(
    'Advice remote datasources',
    () {
      group(
        'should return AdviceModel',
        () {
          test(
            'when client response was 200 and has valid data',
            () async {
              final mockClient = MockClient();
              final adviceRemoteDatasource =
                  AdviceRemoteDatasourceImpl(client: mockClient);
              const responseBody = '{"advice": "test advice", "advice_id": 1}';

              when(
                mockClient.get(
                  Uri.parse('https://api.flutter-community.de/api/v1/advice'),
                  headers: {'content-type': 'application/json'},
                ),
              ).thenAnswer(
                (realInvocation) => Future.value(
                  Response(responseBody, 200),
                ),
              );

              final result =
                  await adviceRemoteDatasource.getRandomAdviceFromApi();
              expect(
                result,
                AdviceModel(advice: 'test advice', id: 1),
              );
            },
          );
        },
      );

      group(
        'should throw',
        () {
          test(
            'a ServerException when Client response was not 200',
            () async {
              final mockClient = MockClient();
              final adviceRemoteDatasource =
                  AdviceRemoteDatasourceImpl(client: mockClient);

              when(
                mockClient.get(
                  Uri.parse('https://api.flutter-community.de/api/v1/advice'),
                  headers: {'content-type': 'application/json'},
                ),
              ).thenAnswer(
                (realInvocation) => Future.value(
                  Response('', 400),
                ),
              );

              expect(
                () => adviceRemoteDatasource.getRandomAdviceFromApi(),
                throwsA(
                  isA<ServerException>(),
                ),
              );
            },
          );

          test(
            'a Type Error when Client response was 200 and no valid data',
                () async {
              final mockClient = MockClient();
              final adviceRemoteDatasource =
              AdviceRemoteDatasourceImpl(client: mockClient);
              const responseBody = '{"advice": "test advice"}';

              when(
                mockClient.get(
                  Uri.parse('https://api.flutter-community.de/api/v1/advice'),
                  headers: {'content-type': 'application/json'},
                ),
              ).thenAnswer(
                    (realInvocation) => Future.value(
                  Response(responseBody, 200),
                ),
              );

              expect(
                    () => adviceRemoteDatasource.getRandomAdviceFromApi(),
                throwsA(
                  isA<TypeError>(),
                ),
              );
            },
          );
        },
      );
    },
  );
}
