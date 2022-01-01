import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          "LOGIN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: _email,
          decoration: const InputDecoration(hintText: "Email"),
        ),
        TextField(
          controller: _password,
          decoration: const InputDecoration(hintText: "Password"),
        ),
        TextButton(
          child: const Text('Login'),
          onPressed: () => submit(),
        ),
      ],
    );
  }

  void submit() {
    // get .text from text editing controllers here
  }
}