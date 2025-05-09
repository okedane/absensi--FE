import 'package:absensi_ui/style/color/colors.dart';
import 'package:flutter/material.dart';

class LemburScreen extends StatefulWidget {
  const LemburScreen({super.key});

  @override
  State<LemburScreen> createState() => _LemburScreenState();
}

class _LemburScreenState extends State<LemburScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryLight,
        title: const Text(
          "Daftar Lembur ",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  elevation: 1,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    title: Text(
                      "2025-12-01",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Memperbaiki System Keamanan"),
                    trailing: Text(
                      "12:00 - 15:00",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
