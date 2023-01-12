import 'package:advicer_app/application/pages/advice/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({Function()? callback}) => MaterialApp(
        home: Scaffold(
          body: CustomButton(
            onTap: callback,
          ),
        ),
      );

  group(
    'CustomButton',
    () {
      group(
        'is Button rendered correctly',
        () {
          testWidgets(
            'and has all parts that it needs',
            (widgetTester) async {
              await widgetTester.pumpWidget(
                widgetUnderTest(),
              );

              final buttonLabelFinder = find.text('Get advice');
              expect(buttonLabelFinder, findsOneWidget);
            },
          );
        },
      );

      group(
        'should handle onTap',
        () {
          testWidgets(
            'when someone has pressed the button',
            (widgetTester) async {
              await widgetTester.pumpWidget(
                widgetUnderTest(
                  callback: () {},
                ),
              );

              final customButtonFinder = find.byType(CustomButton);
              widgetTester.tap(customButtonFinder);
            },
          );
        },
      );
    },
  );
}
