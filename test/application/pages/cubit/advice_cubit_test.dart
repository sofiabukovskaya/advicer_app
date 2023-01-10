import 'package:advicer_app/application/pages/advice/cubit/advice_cubit.dart';
import 'package:advicer_app/application/pages/advice/cubit/advice_state.dart';
import 'package:advicer_app/domain/entities/advice_entity.dart';
import 'package:advicer_app/domain/failures/failures.dart';
import 'package:advicer_app/domain/usecases/advice_usecases.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceUseCases extends Mock implements AdviceUseCases {}

void main() {
  group(
    'AdviceCubit',
    () {
      final mockAdviceUseCase = MockAdviceUseCases();
      group(
        'should emit',
        () {
          blocTest(
            'nothing when no method is called',
            build: () => AdviceCubit(
              adviceUseCases: mockAdviceUseCase,
            ),
            expect: () => const <AdviceCubitState>[],
          );

          blocTest(
            '[AdviceStateLoading, AdviceStateLoaded] when adviceRequested() is called',
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                const Right<Failure, AdviceEntity>(
                  AdviceEntity(advice: 'test advice', id: 1),
                ),
              ),
            ),
            build: () => AdviceCubit(
              adviceUseCases: mockAdviceUseCase,
            ),
            act: (cubit) => cubit.adviceRequested(),
            expect: () => <AdviceCubitState>[
              AdviceStateLoading(),
              const AdviceStateLoaded(advice: 'test advice'),
            ],
          );
        },
      );

      group(
        '[AdviceStateLoading, AdviceStateError] when adviceRequested() is called',
        () {
          blocTest(
            'a ServerFailure occurs',
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  ServerFailure(),
                ),
              ),
            ),
            build: () => AdviceCubit(
              adviceUseCases: mockAdviceUseCase,
            ),
            act: (cubit) => cubit.adviceRequested(),
            expect: () => <AdviceCubitState>[
              AdviceStateLoading(),
              const AdviceStateError(message: 'Server failure'),
            ],
          );

          blocTest(
            'a CacheFailure occurs',
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
                  (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  CacheFailure(),
                ),
              ),
            ),
            build: () => AdviceCubit(
              adviceUseCases: mockAdviceUseCase,
            ),
            act: (cubit) => cubit.adviceRequested(),
            expect: () => <AdviceCubitState>[
              AdviceStateLoading(),
              const AdviceStateError(message: 'Cache failure'),
            ],
          );

          blocTest(
            'a GeneralFailure occurs',
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
                  (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  GeneralFailure(),
                ),
              ),
            ),
            build: () => AdviceCubit(
              adviceUseCases: mockAdviceUseCase,
            ),
            act: (cubit) => cubit.adviceRequested(),
            expect: () => <AdviceCubitState>[
              AdviceStateLoading(),
              const AdviceStateError(message: 'General failure'),
            ],
          );
        },
      );
    },
  );
}
