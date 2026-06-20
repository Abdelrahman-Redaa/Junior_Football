import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable{
  final String? message;
  final bool? isSuccess;
  const RegisterEntity({this.message,this.isSuccess});
  @override
  List<Object?> get props => [message,isSuccess];

}