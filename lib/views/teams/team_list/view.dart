import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/team.dart';
import 'package:meeting_minutes/views/teams/team_info/view.dart';

class TeamList extends StatelessWidget {
  final List<Team> teams;

  const TeamList(this.teams, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: teams.map((team) => TeamInfo(team)).toList(),
    );
  }
}