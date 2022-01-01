import 'package:flutter/material.dart';

class HomeLoggedOut extends StatelessWidget {
  const HomeLoggedOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(child: Text('You are currently logged out.')),
        TextButton(
          onPressed: () {},
          child: const Text('Log In'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}