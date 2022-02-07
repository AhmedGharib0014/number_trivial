import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure implements Exception {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CachFailure extends Failure implements Exception {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
