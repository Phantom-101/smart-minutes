import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:meeting_minutes/data/team.dart';
import 'package:meeting_minutes/views/recordings/create_recording/scaffold.dart';
import 'package:meeting_minutes/views/recordings/recording_list/view.dart';
import 'package:provider/provider.dart';

class TeamDetails extends StatelessWidget {
  final Team team;

  const TeamDetails(this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Card(
          child: ListTile(
            title: Text(team.name),
            subtitle: Text(team.description),
          ),
        ),
        FutureBuilder(
          future: context.read<Database>().getRecordings(team),
          builder: (context, AsyncSnapshot<List<Recording>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return RecordingList(snapshot.data!);
              }
              return const RecordingList([]);
            }
            return const Card(
              child: ListTile(
                title: Text('Loading recordings...'),
              ),
            );
          },
        ),
        Card(
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateRecordingScaffold(team)));
            },
            child: const Text('Create Recording'),
          ),
        ),
      ],
    );
  }
}