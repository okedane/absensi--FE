import 'package:absensi_ui/screens/absensi/absensi_screen.dart';
import 'package:absensi_ui/screens/home/home_screen.dart';
import 'package:absensi_ui/screens/lembur/lembur_screen.dart';
import 'package:absensi_ui/screens/login/login_screen.dart';
import 'package:absensi_ui/style/color/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _indexBottomNavBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (_indexBottomNavBar) {
        0 => const HomeScreen(),
        1 => const AbsensiScreen(),
        2 => const LemburScreen(),
        // 3 => const JabatanMooraScreen(),
        // 4 => const JabatanPeringkatScreen(),
        _ => const LoginScreen(),
      },
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
          elevation: 0, // Menghilangkan shadow bawaan
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          currentIndex: _indexBottomNavBar,
          onTap: (value) {
            setState(() {
              _indexBottomNavBar = value;
            });
          },
          items: [
            // Home item
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      _indexBottomNavBar == 0
                          ? primaryColor.withOpacity(0.1)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.home_rounded,
                  size: 24,
                  color:
                      _indexBottomNavBar == 0
                          ? primaryColor
                          : Colors.grey.shade400,
                ),
              ),
              label: "Home",
              tooltip: "Home",
            ),

            // Absensi item
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      _indexBottomNavBar == 1
                          ? primaryColor.withOpacity(0.1)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.qr_code_scanner,
                  size: 24,
                  color:
                      _indexBottomNavBar == 1
                          ? primaryColor
                          : Colors.grey.shade400,
                ),
              ),
              label: "Absensi",
              tooltip: "Absensi",
            ),

            // Lembur item
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          _indexBottomNavBar == 2
                              ? primaryColor.withOpacity(0.1)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.calendar_month_rounded,
                      size: 24,
                      color:
                          _indexBottomNavBar == 2
                              ? primaryColor
                              : Colors.grey.shade400,
                    ),
                  ),
                  // Badge notifikasi (opsional)
                  // Positioned(
                  //   right: -2,
                  //   top: -2,
                  //   child: Container(
                  //     padding: const EdgeInsets.all(4),
                  //     decoration: BoxDecoration(
                  //       color: Colors.red,
                  //       shape: BoxShape.circle,
                  //       border: Border.all(color: Colors.white, width: 1.5),
                  //     ),
                  //     child: const Text(
                  //       "2",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              label: "Lembur",
              tooltip: "Lembur",
            ),
          ],
        ),
      ),
    );
  }
}
