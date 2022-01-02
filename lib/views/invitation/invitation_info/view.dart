import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/team.dart';

class InvitationInfo extends StatelessWidget {
  final Team team;

  const InvitationInfo(this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(team.name),
        subtitle: Text(team.description),
        trailing: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check, color: Colors.lightGreenAccent),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.close, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}