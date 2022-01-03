import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/team.dart';

import 'view.dart';

class TeamDetailsScaffold extends StatelessWidget {
  final Team team;

  const TeamDetailsScaffold(this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Details'),
      ),
      body: TeamDetails(team),
    );
  }
}