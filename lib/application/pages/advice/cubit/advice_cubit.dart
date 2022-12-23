import 'package:advicer_app/application/pages/advice/cubit/advice_state.dart';
import 'package:advicer_app/domain/usecases/advice_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/failures/failures.dart';

class AdviceCubit extends Cubit<AdviceCubitState> {
  AdviceCubit({
    required this.adviceUseCases,
  }) : super(
          AdviceInitial(),
        );

  final AdviceUseCases adviceUseCases;

  void adviceRequested() async {
    emit(
      AdviceStateLoading(),
    );
    final failureOrAdvice = await adviceUseCases.getAdvice();
    failureOrAdvice.fold(
      (failure) => emit(
        AdviceStateError(
          message: _mapFailureToMessage(failure),
        ),
      ),
      (advice) => emit(
        AdviceStateLoaded(
          advice: advice.advice,
        ),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';

      case GeneralFailure:
        return 'General failure';
      default:
        return 'Something gone wrong!';
    }
  }
}
