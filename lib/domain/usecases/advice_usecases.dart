import 'package:advicer_app/domain/entities/advice_entity.dart';
import 'package:advicer_app/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdviceUseCases {
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () {},
    );
    return right(
      const AdviceEntity(advice: 'test advice', id: 1),
    );
  }

}
