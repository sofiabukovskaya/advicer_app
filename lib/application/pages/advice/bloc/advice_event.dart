import 'package:equatable/equatable.dart';

abstract class AdviceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdviceRequestEvent extends AdviceEvent {}
