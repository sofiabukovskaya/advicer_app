import 'package:advicer_app/application/pages/advice/bloc/advice_bloc.dart';
import 'package:advicer_app/application/pages/advice/bloc/advice_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkResponse(
      onTap: () => BlocProvider.of<AdviceBloc>(context).add(
        AdviceRequestEvent(),
      ),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(15),
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.colorScheme.secondary),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(
              'Get advice',
              style: theme.textTheme.headline1,
            ),
          ),
        ),
      ),
    );
  }
}
