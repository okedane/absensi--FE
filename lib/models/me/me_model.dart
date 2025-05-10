class MeResponse {
  final User user;
  final Karyawan karyawan;

  MeResponse({required this.user, required this.karyawan});

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    return MeResponse(
      user: User.fromJson(json['data']['user']),
      karyawan: Karyawan.fromJson(json['data']['karyawan']),
    );
  }
}

class Karyawan {
  final int id;
  final String namaKaryawan;
  final Jabatan jabatan;
  final String qrToken; // Menambahkan qrToken

  Karyawan({
    required this.id,
    required this.namaKaryawan,
    required this.jabatan,
    required this.qrToken, // Menambahkan qrToken
  });

  factory Karyawan.fromJson(Map<String, dynamic> json) {
    return Karyawan(
      id: json['id'],
      namaKaryawan: json['nama_karyawan'],
      jabatan: Jabatan.fromJson(json['jabatan']),
      qrToken: json['qr_token'] ?? '', // Menangani null dengan memberikan nilai default ''
    );
  }
}


class Jabatan {
  final int id;
  final String namaJabatan;

  Jabatan({required this.id, required this.namaJabatan});

  factory Jabatan.fromJson(Map<String, dynamic> json) {
    return Jabatan(id: json['id'], namaJabatan: json['nama_jabatan']);
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], email: json['email']);
  }
}
