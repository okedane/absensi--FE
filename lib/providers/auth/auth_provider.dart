import 'dart:async';
import 'dart:io';

import 'package:absensi_ui/services/api_services.dart';
import 'package:absensi_ui/static/navigation_route.dart';
import 'package:absensi_ui/utils/login_result_state.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService apiService;

  LoginResultState _state = LoginNoneState();
  LoginResultState get state => _state;

  AuthProvider({required this.apiService});

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    _state = LoginLoadingState();
    notifyListeners();

    try {
      final result = await apiService.login(email: email, password: password);

      _state = LoginSuccessState(
        message: result.message,
        token: result.token,
        user: result.user,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result.token);
      await prefs.setString('userName', result.user.name);
      await prefs.setString('userEmail', result.user.email);

      Navigator.pushReplacementNamed(context, NavigationRoute.home.route);
    } catch (e) {
      String errorMessage = 'Terjadi kesalahan tidak diketahui';

      if (e is SocketException) {
        errorMessage = 'Tidak dapat terhubung ke server';
      } else if (e is Exception) {
        errorMessage = e.toString(); // Menampilkan pesan error spesifik
      } else {
        errorMessage = e.toString();
      }

      _state = LoginErrorState(errorMessage); // Set error message
    }

    notifyListeners();
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final route = token != null ? NavigationRoute.home : NavigationRoute.login;

    // Pindahkan navigator ke dalam addPostFrameCallback agar tidak trigger rebuild errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, route.route);
    });
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // hapus token
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('/login', (route) => false); // arahkan ke login
  }
}
