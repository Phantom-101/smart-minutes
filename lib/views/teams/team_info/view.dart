import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/team.dart';

class TeamInfo extends StatelessWidget {
  final Team team;

  const TeamInfo(this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: ListTile(
          title: Text(team.name),
          subtitle: Text(team.description),
        ),
      ),
    );
  }
}