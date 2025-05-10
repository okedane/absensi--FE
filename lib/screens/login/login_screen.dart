import 'package:absensi_ui/providers/auth/auth_provider.dart';
import 'package:absensi_ui/utils/login_result_state.dart';
import 'package:absensi_ui/widgets/button/button_widget.dart';
import 'package:absensi_ui/widgets/textField/textField_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hasShownError = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 70,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'Masuk Untuk Melanjutkan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextfieldWidget(
                          hinText: 'Email',
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextfieldWidget(
                          hinText: 'Password',
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Consumer<AuthProvider>(
                          builder: (context, auth, _) {
                            return ButtonWidget(
                              label: 'Login',
                              isLoading: auth.state is LoginLoadingState,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final authProvider =
                                      Provider.of<AuthProvider>(
                                        context,
                                        listen: false,
                                      );
                                  authProvider.login(
                                    emailController.text,
                                    passwordController.text,
                                    context,
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Consumer<AuthProvider>(
                    builder: (context, auth, child) {
                      if (auth.state is LoginErrorState) {
                        final errorMessage =
                            (auth.state as LoginErrorState).error;

                        if (!_hasShownError) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                                backgroundColor: Colors.red,
                              ),
                            );
                            _hasShownError = true;
                          });
                        }

                        return const SizedBox.shrink();
                      } else {
                        _hasShownError = false; // reset kalau berhasil
                        return const SizedBox.shrink();
                      }
                    },
                  ),

                  const SizedBox(height: 100.0),
                  Text('Lupa Password ?'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
