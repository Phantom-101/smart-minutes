import 'package:flutter/material.dart';

import 'view.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: LoginScreen(),
    );
  }
}