import '../../domain/login/model/user_model.dart';

abstract class LoginState {}

class LoginStateEmpty extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateFailure extends LoginState {
  final String message;
  LoginStateFailure({
    required this.message,
  });
}

class LoginStateSuccess extends LoginState {
  final UserModel user;
  LoginStateSuccess({
    required this.user,
  });
}
