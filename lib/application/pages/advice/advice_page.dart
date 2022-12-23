import 'package:advicer_app/application/core/services/theme_service.dart';

import 'package:advicer_app/application/pages/advice/cubit/advice_cubit.dart';
import 'package:advicer_app/application/pages/advice/cubit/advice_state.dart';
import 'package:advicer_app/application/pages/advice/widgets/advice_field.dart';
import 'package:advicer_app/application/pages/advice/widgets/custom_button.dart';
import 'package:advicer_app/application/pages/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../injection.dart';

class AdvicePageWrapperProvider extends StatelessWidget {
  const AdvicePageWrapperProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdviceCubit>(),
      child: const AdvicePage(),
    );
  }
}

class AdvicePage extends StatelessWidget {
  const AdvicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advicer',
          style: themeData.textTheme.headline1,
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (_) {
              Provider.of<ThemeService>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdviceCubit, AdviceCubitState>(
                  builder: (context, state) {
                    if (state is AdviceInitial) {
                      return Text(
                        'Your advice is waiting for you!',
                        style: themeData.textTheme.headline1,
                      );
                    } else if (state is AdviceStateLoading) {
                      return CircularProgressIndicator(
                        color: themeData.colorScheme.secondary,
                      );
                    } else if (state is AdviceStateLoaded) {
                      return AdviceField(advice: state.advice);
                    } else if (state is AdviceStateError) {
                      return ErrorMessage(errorMessage: state.message);
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 200,
              child: Center(
                child: CustomButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
