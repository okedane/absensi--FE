import 'package:absensi_ui/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AuthCheckingScreen extends StatefulWidget {
  const AuthCheckingScreen({super.key});

  @override
  State<AuthCheckingScreen> createState() => _AuthCheckingScreenState();
}

class _AuthCheckingScreenState extends State<AuthCheckingScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).checkLoginStatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
