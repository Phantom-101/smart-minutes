import 'package:flutter/material.dart';

import 'view.dart';

class LandingScaffold extends StatelessWidget {
  const LandingScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing'),
      ),
      body: const Landing(),
    );
  }
}