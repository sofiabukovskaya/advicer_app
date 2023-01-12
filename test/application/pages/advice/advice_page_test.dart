import 'package:advicer_app/application/core/services/theme_service.dart';
import 'package:advicer_app/application/pages/advice/advice_page.dart';
import 'package:advicer_app/application/pages/advice/cubit/advice_cubit.dart';
import 'package:advicer_app/application/pages/advice/cubit/advice_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class MockAdviceCubit extends MockCubit<AdviceCubitState>
    implements AdviceCubit {}

void main() {
  Widget widgetUnderTest({required AdviceCubit cubit}) => MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => ThemeService(),
          child: BlocProvider<AdviceCubit>(
            create: (context) => cubit,
            child: const AdvicePage(),
          ),
        ),
      );

  group(
    'AdvicePage',
    () {
      late AdviceCubit mockAdviceCubit;
      setUp(
        () => mockAdviceCubit = MockAdviceCubit(),
      );

      group(
        'should be displayed in ViewState',
        () {
          testWidgets(
            'Initial when cubit emits AdviceInitial()',
            (widgetTester) async {
              whenListen(
                mockAdviceCubit,
                Stream.fromIterable(
                  [
                    AdviceInitial(),
                  ],
                ),
                initialState: AdviceInitial(),
              );

              await widgetTester.pumpWidget(
                widgetUnderTest(cubit: mockAdviceCubit),
              );

              final adviceInitialTextFinder =
                  find.text('Your advice is waiting for you!');
              expect(adviceInitialTextFinder, findsOneWidget);
            },
          );

          testWidgets(
            'Loading when cubit emits AdviceStateLoading()',
            (widgetTester) async {
              whenListen(
                mockAdviceCubit,
                Stream.fromIterable(
                  [
                    AdviceStateLoading(),
                  ],
                ),
                initialState: AdviceInitial(),
              );

              await widgetTester.pumpWidget(
                widgetUnderTest(cubit: mockAdviceCubit),
              );
              await widgetTester.pump();

              final adviceLoadingFinder =
                  find.byType(CircularProgressIndicator);
              expect(adviceLoadingFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
