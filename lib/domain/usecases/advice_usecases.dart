import 'package:advicer_app/data/repositories/advice_repo_impl.dart';
import 'package:advicer_app/domain/entities/advice_entity.dart';
import 'package:advicer_app/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdviceUseCases {
  AdviceUseCases({
    required this.adviceRepo,
  });
  final AdviceRepoImpl adviceRepo;

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDataSource();
  }
}
