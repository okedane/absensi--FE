class LoginResponse {
  final bool success;
  final String message;
  final User user;
  final String token;

  LoginResponse({
    required this.success,
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return LoginResponse(
      success: json['success'],
      message: json['message'],
      user: User.fromJson(data), // ← perbaikan di sini
      token: data['token'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'], // ← sesuai dengan struktur dari JSON
      name: json['name'],
      email: json['email'],
    );
  }
}
