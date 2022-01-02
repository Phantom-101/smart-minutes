import 'package:flutter/material.dart';

import 'view.dart';

class CreateTeamScaffold extends StatelessWidget {
  const CreateTeamScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Team'),
      ),
      body: CreateTeam(),
    );
  }
}