import 'package:absensi_ui/models/me/me_model.dart';

sealed class MeResultState {}

class MeNoneState extends MeResultState {}

class MeLoadingState extends MeResultState {}

class MeErrorState extends MeResultState {
  final String error;

  MeErrorState(this.error);
}

class MeLoadedState extends MeResultState {
  final MeResponse me;

  MeLoadedState(this.me);
}
