import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa Password'),
      ),
      body: const Center(
        child: Text(
          'Halaman 2: Formulir Lupa Password',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
