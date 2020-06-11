import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure();

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}
