import 'package:advicer_app/application/pages/advice/cubit/advice_cubit.dart';
import 'package:advicer_app/data/datasources/advice_remote_datasource.dart';
import 'package:advicer_app/data/repositories/advice_repo_impl.dart';
import 'package:advicer_app/domain/repositories/advice_repository.dart';
import 'package:advicer_app/domain/usecases/advice_usecases.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.I;

Future<void> init() async {
// ! application Layer
  // Factory = every time a new/fresh instance of that class
  sl.registerFactory(() => AdviceCubit(adviceUseCases: sl()));

// ! domain Layer
  sl.registerFactory(() => AdviceUseCases(adviceRepo: sl()));

// ! data Layer
  sl.registerFactory<AdviceRepository>(
      () => AdviceRepoImpl(adviceRemoteDatasource: sl()));
  sl.registerFactory<AdviceRemoteDatasource>(
      () => AdviceRemoteDatasourceImpl(client: sl()));

// ! externs
  sl.registerFactory(() => http.Client());
}
