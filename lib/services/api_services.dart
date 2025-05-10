import 'dart:convert';
import 'dart:io';

import 'package:absensi_ui/models/me/me_model.dart';
import 'package:absensi_ui/models/user/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl =
      "https://f0a6-103-160-202-114.ngrok-free.app/api";

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$_baseUrl/login");

    final response = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['success'] == true) {
        return LoginResponse.fromJson(body);
      } else {
        // Jika sukses = false, lempar exception dengan pesan dari server
        throw Exception(body['message'] ?? 'Login gagal');
      }
    } else if (response.statusCode == 401) {
      // 401 Unauthorized, biasanya terjadi karena password atau email salah
      throw Exception('Password salah atau email tidak ditemukan');
    } else if (response.statusCode == 400) {
      // 400 Bad Request, bisa berarti parameter yang salah, misal email/password kosong
      throw Exception('Permintaan tidak valid');
    } else {
      // Untuk error server lainnya, misalnya 500 (Internal Server Error)
      throw Exception('Terjadi kesalahan server');
    }
  }

  Future<void> logout(String token) async {
    final url = Uri.parse("$_baseUrl/logout");

    final response = await http.post(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Logout gagal');
    }
  }

  Future<MeResponse> getMe(String token, {http.Client? client}) async {
    final httpClient = client ?? http.Client();

    final response = await httpClient.get(
      Uri.parse("$_baseUrl/me"),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}"); // Verifikasi body response

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return MeResponse.fromJson(body);
    } else {
      throw Exception('Gagal mengambil data pengguna (${response.statusCode})');
    }
  }
}
