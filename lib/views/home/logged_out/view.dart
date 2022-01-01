import 'package:flutter/material.dart';
import 'package:meeting_minutes/views/login/scaffold.dart';
import 'package:meeting_minutes/views/register/scaffold.dart';


class HomeLoggedOut extends StatelessWidget {
  const HomeLoggedOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(child: Text('You are currently logged out.')),
        TextButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScaffold()),
            );
          },
          child: const Text('Log In'),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterScaffold()),
            );
          },
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}