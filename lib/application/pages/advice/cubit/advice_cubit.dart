import 'package:advicer_app/application/pages/advice/cubit/advice_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdviceCubit extends Cubit<AdviceCubitState> {
  AdviceCubit()
      : super(
          AdviceInitial(),
        );

  void adviceRequested() async {
    emit(
      AdviceStateLoading(),
    );

    await Future.delayed(
        const Duration(
          seconds: 2,
        ),
        () {});
    emit(
      const AdviceStateLoaded(advice: 'test advice'),
    );
  }
}
