import 'package:absensi_ui/style/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:absensi_ui/providers/main/index_nav_provider.dart';
import 'package:absensi_ui/screens/home/home_screen.dart';
import 'package:absensi_ui/screens/absensi/absensi_screen.dart';
import 'package:absensi_ui/screens/lembur/lembur_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomeScreen(),
            1 => const AbsensiScreen(),
            _ => const LemburScreen(),
          };
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 15,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
          onTap: (value) {
            context.read<IndexNavProvider>().setIndexBottomNavBar = value;
          },
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner),
              label: "Absensi",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Lembur",
            ),
          ],
        ),
      ),
    );
  }
}
