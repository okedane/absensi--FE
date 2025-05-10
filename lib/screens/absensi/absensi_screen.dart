import 'package:absensi_ui/providers/me/me_provider.dart';
import 'package:absensi_ui/style/color/colors.dart';
import 'package:absensi_ui/utils/me_result_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AbsensiScreen extends StatelessWidget {
  const AbsensiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryLight,
        title: const Text(
          "Scan QR ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: Icon(Icons.person, color: primaryColor, size: 20),
            ),
          ),
        ],
      ),
      body: Consumer<MeProvider>(
        builder: (context, provider, _) {
          final state = provider.resultState;
          if (state is MeLoadedState) {
            final qrToken = state.me.karyawan.qrToken;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: whiteC,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: QrImageView(data: qrToken),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    "Arahkan kamera ke QR Code yang tersedia",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (state is MeLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MeErrorState) {
            return Center(child: Text("Gagal memuat data: ${state.error}"));
          } else {
            return Center(child: Text("Data tidak tersedia"));
          }
        },
      ),
    );
  }
}
