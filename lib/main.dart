import 'package:absensi_ui/providers/auth/auth_provider.dart';
import 'package:absensi_ui/providers/main/index_nav_provider.dart';
import 'package:absensi_ui/providers/me/me_provider.dart';
import 'package:absensi_ui/screens/auth/auth_checking_screen.dart';
import 'package:absensi_ui/screens/home/home_screen.dart';
import 'package:absensi_ui/screens/login/login_screen.dart';
import 'package:absensi_ui/screens/main/main_screen.dart';
import 'package:absensi_ui/services/api_services.dart';
import 'package:absensi_ui/static/navigation_route.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(
          create:
              (context) => AuthProvider(apiService: context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => MeProvider(context.read<ApiService>()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthCheckingScreen(),
        NavigationRoute.login.path: (context) => const LoginScreen(),
        NavigationRoute.home.path: (context) => const MainScreen(),
      },
    );
  }
}
