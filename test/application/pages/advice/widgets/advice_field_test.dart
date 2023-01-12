import 'package:advicer_app/application/pages/advice/widgets/advice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderText({required String text}) => MaterialApp(
        home: AdviceField(
          advice: text,
        ),
      );

  group(
    'AdviceField',
    () {
      group(
        'should be displayed correctly',
        () {
          testWidgets(
            'when a short text is given',
            (widgetTester) async {
              const text = 'a';
              await widgetTester.pumpWidget(
                widgetUnderText(text: text),
              );
              await widgetTester.pumpAndSettle();

              final adviceFieldFinder = find.textContaining('a');
              expect(adviceFieldFinder, findsOneWidget);
            },
          );

          testWidgets(
            'when a long text is given',
            (widgetTester) async {
              const text =
                  'hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello';
              await widgetTester.pumpWidget(
                widgetUnderText(text: text),
              );
              await widgetTester.pumpAndSettle();

              final adviceFieldFinder = find.byType(AdviceField);
              expect(adviceFieldFinder, findsOneWidget);
            },
          );

          testWidgets(
            'when no text is given',
                (widgetTester) async {
              const text = '';
              await widgetTester.pumpWidget(
                widgetUnderText(text: text),
              );
              await widgetTester.pumpAndSettle();

              final adviceFieldFinder = find.byType(AdviceField);
              expect(adviceFieldFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
