import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:meeting_minutes/data/team.dart';
import 'package:meeting_minutes/data/user.dart';
import 'package:meeting_minutes/views/teams/team_details/scaffold.dart';
import 'package:provider/provider.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({Key? key}) : super(key: key);

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();

  bool _creating = false;

  @override
  Widget build(BuildContext context) {
    if (_creating) {
      return const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Creating your team...'),
          ),
        ),
      );
    }

    return ListView(
      children: [
        const SizedBox(height: 50),
        Center(
          child: SizedBox(
            width: 400,
            child: TextField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 400,
            child: TextField(
              controller: _description,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Center(
          child: SizedBox(
            width: 100,
            child: TextButton(
              onPressed: () async {
                setState(() {
                  _creating = true;
                });
                Team team = await context.read<Database>().addTeam(context.read<User>(), _name.text, _description.text);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TeamDetailsScaffold(team)));
              },
              child: const Text('Create'),
            ),
          ),
        ),
      ],
    );
  }
}