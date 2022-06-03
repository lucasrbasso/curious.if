abstract class SignUpState {}

class SignUpStateEmpty extends SignUpState {}

class SignUpStateLoading extends SignUpState {}

class SignUpStateFailure extends SignUpState {
  final String message;
  SignUpStateFailure({
    required this.message,
  });
}

class SignUpStateSuccess extends SignUpState {
  final String email;
  SignUpStateSuccess({
    required this.email,
  });
}
