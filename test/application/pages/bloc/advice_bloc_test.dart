import 'package:advicer_app/application/pages/advice/bloc/advice_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'AdviceBloc',
    () {
      group(
        'should emit',
        () {
          blocTest<AdviceBloc, AdvicerState>(
            'nothing when no event is added',
            build: () => AdviceBloc(),
            expect: () => const <AdvicerState>[],
          );

          blocTest(
            '[AdvicerStateLoading, AdvicerStateError] when AdviceRequestedEvent added',
            build: () => AdviceBloc(),
            act: (bloc) => bloc.add(
              AdviceRequestedEvent(),
            ),
            wait: const Duration(seconds: 3),
            expect: () => <AdvicerState>[
              AdvicerStateLoading(),
              AdvicerStateError(message: 'error message'),
            ],
          );
        },
      );
    },
  );
}
