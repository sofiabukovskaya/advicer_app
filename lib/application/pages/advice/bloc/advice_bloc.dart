import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advice_event.dart';
part 'advice_state.dart';

class AdviceBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdviceBloc() : super(AdvicerInitial()) {
    on<AdviceRequestedEvent>(
      (event, emit) async {
        emit(AdvicerStateLoading());
        // execute business logic
        // for example get and advice
        debugPrint('fake get advice triggered');
        await Future.delayed(
          const Duration(seconds: 3),
          () {},
        );
        debugPrint('got advice');
        //emit(AdvicerStateLoaded(advice: 'fake advice to test bloc'));
        emit(
          AdvicerStateError(message: 'error message'),
        );
      },
    );
  }
}
