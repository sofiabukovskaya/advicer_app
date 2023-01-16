import 'package:advicer_app/application/pages/advice/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({Function()? onTap}) => MaterialApp(
    home: Scaffold(
      body: CustomButton(
            onTap: onTap,
          ),
    ),
  );

  group(
    'Golden test',
    () {
      group(
        'Custom button',
        () {
          testWidgets(
            'is enabled',
            (widgetTester) async {
              await widgetTester.pumpWidget(
                widgetUnderTest(
                  onTap: () {},
                ),
              );

              await expectLater(find.byType(CustomButton), matchesGoldenFile('goldens/custom_button_enabled.png'),);
            },
          );
        },
      );
    },
  );
}
