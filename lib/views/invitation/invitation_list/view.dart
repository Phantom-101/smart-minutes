import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/team.dart';
import 'package:meeting_minutes/views/invitation/invitation_info/view.dart';

class InvitationList extends StatelessWidget {
  final List<Team> teams;

  const InvitationList(this.teams, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: teams.map((team) => InvitationInfo(team)).toList(),
    );
  }
}