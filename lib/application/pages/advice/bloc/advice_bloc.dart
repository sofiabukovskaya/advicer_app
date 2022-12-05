import 'package:advicer_app/application/pages/advice/bloc/advice_event.dart';
import 'package:advicer_app/application/pages/advice/bloc/advice_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  AdviceBloc() : super(AdviceInitial()) {
    on<AdviceRequestEvent>(
      (event, emit) async {
        emit(
          AdviceStateLoading(),
        );

        await Future.delayed(
            const Duration(
              seconds: 2,
            ),
            () {});
        emit(
          AdviceStateLoaded(advice: 'test advice'),
        );
      },
    );
  }
}
