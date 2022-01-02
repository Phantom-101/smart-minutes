import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/team.dart';

import 'view.dart';

class TeamListScaffold extends StatelessWidget {
  final List<Team> teams;

  const TeamListScaffold(this.teams, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
      ),
      body: TeamList(teams),
    );
  }
}