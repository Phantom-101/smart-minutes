import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/team.dart';

import 'view.dart';

class InvitationListScaffold extends StatelessWidget {
  final List<Team> teams;

  const InvitationListScaffold(this.teams, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitations'),
      ),
      body: InvitationList(teams),
    );
  }
}