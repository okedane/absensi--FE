import 'package:absensi_ui/services/api_services.dart';
import 'package:absensi_ui/utils/me_result_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeProvider extends ChangeNotifier {
  final ApiService _apiService;

  MeProvider(this._apiService);

  MeResultState _resultState = MeNoneState();
  MeResultState get resultState => _resultState; // <- perbaikan nama getter

  Future<void> getMe() async {
    _resultState = MeLoadingState();
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print("Token from SharedPreferences: $token"); // Verifikasi token

      if (token == null) throw Exception("Token not found");

      final me = await _apiService.getMe(token);
      _resultState = MeLoadedState(me);
    } catch (e) {
      _resultState = MeErrorState(e.toString());
    }

    notifyListeners();
  }
}
