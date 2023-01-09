import 'dart:io';

import 'package:advicer_app/data/datasources/advice_remote_datasource.dart';
import 'package:advicer_app/data/exceptions/exceptions.dart';
import 'package:advicer_app/data/models/advice_model.dart';
import 'package:advicer_app/data/repositories/advice_repo_impl.dart';
import 'package:advicer_app/domain/entities/advice_entity.dart';
import 'package:advicer_app/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDatasourceImpl>()])
void main() {
  group(
    'Advice repository impl',
    () {
      group(
        'should return AdviceEntity',
        () {
          test(
            'when AdviceRemoteDatasource returns a AdviceModel',
            () async {
              final mockAdviceRemoteDatasourceImpl =
                  MockAdviceRemoteDatasourceImpl();
              final adviceRepository = AdviceRepoImpl(
                  adviceRemoteDatasource: mockAdviceRemoteDatasourceImpl);

              when(
                mockAdviceRemoteDatasourceImpl.getRandomAdviceFromApi(),
              ).thenAnswer(
                (realInvocation) => Future.value(
                  AdviceModel(
                    advice: 'test_advice',
                    id: 40,
                  ),
                ),
              );

              final result = await adviceRepository.getAdviceFromDataSource();
              expect(result.isLeft(), false);
              expect(result.isRight(), true);
              expect(
                result,
                Right<Failure, AdviceModel>(
                  AdviceModel(advice: 'test_advice', id: 40),
                ),
              );
              verify(
                mockAdviceRemoteDatasourceImpl.getRandomAdviceFromApi(),
              ).called(1);
              verifyNoMoreInteractions(mockAdviceRemoteDatasourceImpl);
            },
          );
        },
      );

      group(
        'should return left',
        () {
          test(
            'a ServerFailure when ServerException occurs',
            () async {
              final mockAdviceRemoteDatasourceImpl =
                  MockAdviceRemoteDatasourceImpl();
              final adviceRepository = AdviceRepoImpl(
                  adviceRemoteDatasource: mockAdviceRemoteDatasourceImpl);

              when(
                mockAdviceRemoteDatasourceImpl.getRandomAdviceFromApi(),
              ).thenThrow(
                ServerException(),
              );

              final result = await adviceRepository.getAdviceFromDataSource();
              expect(result.isLeft(), true);
              expect(result.isRight(), false);
              expect(
                result,
                Left<Failure, AdviceEntity>(
                  ServerFailure(),
                ),
              );
            },
          );

          test(
            'a GeneralFailure occurs on all other exceptions',
            () async {
              final mockAdviceRemoteDatasourceImpl =
                  MockAdviceRemoteDatasourceImpl();
              final adviceRepository = AdviceRepoImpl(
                  adviceRemoteDatasource: mockAdviceRemoteDatasourceImpl);

              when(
                mockAdviceRemoteDatasourceImpl.getRandomAdviceFromApi(),
              ).thenThrow(
                const SocketException('test'),
              );

              final result = await adviceRepository.getAdviceFromDataSource();
              expect(result.isLeft(), true);
              expect(result.isRight(), false);
              expect(
                result,
                Left<Failure, AdviceEntity>(
                  GeneralFailure(),
                ),
              );
            },
          );
        },
      );
    },
  );
}
