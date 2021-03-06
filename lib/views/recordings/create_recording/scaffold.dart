import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/team.dart';

import 'view.dart';

class CreateRecordingScaffold extends StatelessWidget {
  final Team team;

  const CreateRecordingScaffold(this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recording'),
      ),
      body: CreateRecording(team),
    );
  }
}