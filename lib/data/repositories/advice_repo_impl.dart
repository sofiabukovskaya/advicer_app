import 'package:advicer_app/data/datasources/advice_remote_datasource.dart';
import 'package:advicer_app/data/exceptions/exceptions.dart';
import 'package:advicer_app/domain/entities/advice_entity.dart';
import 'package:advicer_app/domain/failures/failures.dart';
import 'package:advicer_app/domain/repositories/advice_repository.dart';
import 'package:dartz/dartz.dart';

class AdviceRepoImpl implements AdviceRepository {
  final AdviceRemoteDatasourceImpl adviceRemoteDatasource =
      AdviceRemoteDatasourceImpl();

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(
        ServerFailure(),
      );
    } catch (e) {
      return left(
        GeneralFailure(),
      );
    }
  }
}
