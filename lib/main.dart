import 'package:absensi_ui/screens/login/login_screen.dart';
import 'package:absensi_ui/style/color/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blue,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
