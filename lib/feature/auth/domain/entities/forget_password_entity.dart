import 'package:equatable/equatable.dart';

class EmailVerificationResponseEntity extends Equatable {
  final String? message;

  final String? into;

  const EmailVerificationResponseEntity({this.message, this.into});

  @override
  List<Object?> get props => [message, into];
}

class VerificationCodeResponseEntity extends Equatable {
  const VerificationCodeResponseEntity(this.status);

  @override
  List<Object?> get props => [status];

  final String? status;
}

class RestPasswordResponseEntity extends Equatable {
  final String? message;
  const RestPasswordResponseEntity(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];

}

class ResetPasswordResponseEntity extends Equatable {
  final String? message;
  final String? token;

  const ResetPasswordResponseEntity({this.message, this.token});

  @override
  List<Object?> get props => [message, token];
}

class UserOTPEntity extends Equatable {
  final String? email;

  final String? code;

  final String? password;

  const UserOTPEntity({this.email, this.code, this.password});

  UserOTPEntity copyWith({String? email,  String? password}) {
    return UserOTPEntity(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [email, password];
}
