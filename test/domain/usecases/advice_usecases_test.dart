import 'package:advicer_app/data/repositories/advice_repo_impl.dart';
import 'package:advicer_app/domain/entities/advice_entity.dart';
import 'package:advicer_app/domain/failures/failures.dart';
import 'package:advicer_app/domain/usecases/advice_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImpl>()])
void main() {
  group(
    'Advice usecases test',
    () {
      test(
        'should return advice and when AdviceRepoImpl returns a AdviceModel',
        () async {
          final mockAdviceRepositoryImpl = MockAdviceRepoImpl();
          final adviceUseCase =
              AdviceUseCases(adviceRepo: mockAdviceRepositoryImpl);

          when(adviceUseCase.getAdvice()).thenAnswer(
            (realInvocation) => Future.value(
              right(
                const AdviceEntity(advice: 'test_advice', id: 1),
              ),
            ),
          );

          final result = await adviceUseCase.getAdvice();
          expect(result.isRight(), true);
          expect(result.isLeft(), false);
          expect(
            result,
            const Right<Failure, AdviceEntity>(
              AdviceEntity(advice: 'test_advice', id: 1),
            ),
          );
          verify(
            mockAdviceRepositoryImpl.getAdviceFromDataSource(),
          ).called(1);
          verifyNoMoreInteractions(mockAdviceRepositoryImpl);
        },
      );

      group(
        'should returns left with',
        () {
          test(
            'a ServerFailure',
            () async {
              final mockAdviceRepositoryImpl = MockAdviceRepoImpl();
              final adviceUseCase =
                  AdviceUseCases(adviceRepo: mockAdviceRepositoryImpl);

              when(adviceUseCase.getAdvice()).thenAnswer(
                (realInvocation) => Future.value(
                  left(
                    ServerFailure(),
                  ),
                ),
              );

              final result = await adviceUseCase.getAdvice();
              expect(result.isRight(), false);
              expect(result.isLeft(), true);
              expect(
                result,
                Left<Failure, AdviceEntity>(
                  ServerFailure(),
                ),
              );
            },
          );

          test(
            'a GeneralFailure',
                () async {
              final mockAdviceRepositoryImpl = MockAdviceRepoImpl();
              final adviceUseCase =
              AdviceUseCases(adviceRepo: mockAdviceRepositoryImpl);

              when(adviceUseCase.getAdvice()).thenAnswer(
                    (realInvocation) => Future.value(
                  left(
                    GeneralFailure(),
                  ),
                ),
              );

              final result = await adviceUseCase.getAdvice();
              expect(result.isRight(), false);
              expect(result.isLeft(), true);
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
