import 'package:absensi_ui/models/user/user_model.dart';

sealed class UserListResulState {}

class UserListNoneState extends UserListResulState {}

class UserListLoadingState extends UserListResulState {}

class UserErrorState extends UserListResulState {
  final String error;

  UserErrorState(this.error);
}

class UserListLoadedState extends UserListResulState {
  final List<User> data;

  UserListLoadedState(this.data);
}
