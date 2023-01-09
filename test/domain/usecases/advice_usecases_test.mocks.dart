// Mocks generated by Mockito 5.3.2 from annotations
// in advicer_app/test/domain/usecases/advice_usecases_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:advicer_app/data/datasources/advice_remote_datasource.dart'
    as _i2;
import 'package:advicer_app/data/repositories/advice_repo_impl.dart' as _i4;
import 'package:advicer_app/domain/entities/advice_entity.dart' as _i7;
import 'package:advicer_app/domain/failures/failures.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAdviceRemoteDatasourceImpl_0 extends _i1.SmartFake
    implements _i2.AdviceRemoteDatasourceImpl {
  _FakeAdviceRemoteDatasourceImpl_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AdviceRepoImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdviceRepoImpl extends _i1.Mock implements _i4.AdviceRepoImpl {
  @override
  _i2.AdviceRemoteDatasourceImpl get adviceRemoteDatasource =>
      (super.noSuchMethod(
        Invocation.getter(#adviceRemoteDatasource),
        returnValue: _FakeAdviceRemoteDatasourceImpl_0(
          this,
          Invocation.getter(#adviceRemoteDatasource),
        ),
        returnValueForMissingStub: _FakeAdviceRemoteDatasourceImpl_0(
          this,
          Invocation.getter(#adviceRemoteDatasource),
        ),
      ) as _i2.AdviceRemoteDatasourceImpl);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.AdviceEntity>>
      getAdviceFromDataSource() => (super.noSuchMethod(
            Invocation.method(
              #getAdviceFromDataSource,
              [],
            ),
            returnValue:
                _i5.Future<_i3.Either<_i6.Failure, _i7.AdviceEntity>>.value(
                    _FakeEither_1<_i6.Failure, _i7.AdviceEntity>(
              this,
              Invocation.method(
                #getAdviceFromDataSource,
                [],
              ),
            )),
            returnValueForMissingStub:
                _i5.Future<_i3.Either<_i6.Failure, _i7.AdviceEntity>>.value(
                    _FakeEither_1<_i6.Failure, _i7.AdviceEntity>(
              this,
              Invocation.method(
                #getAdviceFromDataSource,
                [],
              ),
            )),
          ) as _i5.Future<_i3.Either<_i6.Failure, _i7.AdviceEntity>>);
}
