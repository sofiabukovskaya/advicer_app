import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key, required this.errorMessage}) : super(key: key);
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          color: Colors.redAccent,
          size: 40,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          errorMessage,
          style: themeData.textTheme.headline1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
