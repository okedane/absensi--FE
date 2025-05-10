import 'package:absensi_ui/models/user/user_model.dart';

sealed class LoginResultState {}

class LoginNoneState extends LoginResultState {}

class LoginLoadingState extends LoginResultState {}

class LoginErrorState extends LoginResultState {
  final String error;

  LoginErrorState(this.error);
}

class LoginSuccessState extends LoginResultState {
  final String message;
  final String token;
  final User user;

  LoginSuccessState({
    required this.message,
    required this.token,
    required this.user,
  });
}
