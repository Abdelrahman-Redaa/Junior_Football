import 'package:equatable/equatable.dart';

abstract class AppFailure extends Equatable implements Exception {
  final String? message;
  const AppFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure(super.message);
}

class ServerFailure extends AppFailure {
  final int? code;
  const ServerFailure(super.message, {this.code});

  @override
  List<Object?> get props => [message, code];
}

class ConnectionFailure extends AppFailure {
  const ConnectionFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class NoInternetFailure extends AppFailure {
  const NoInternetFailure([String super.message = 'No internet connection']);

  @override
  List<Object?> get props => [message];
}
