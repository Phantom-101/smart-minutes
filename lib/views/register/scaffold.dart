import 'package:flutter/material.dart';

import 'view.dart';

class RegisterScaffold extends StatelessWidget {
  const RegisterScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const RegisterScreen(),
    );
  }
}