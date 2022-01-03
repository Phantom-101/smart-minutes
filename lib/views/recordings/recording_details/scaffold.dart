import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/recording.dart';

import 'view.dart';

class RecordingDetailsScaffold extends StatelessWidget {
  final Recording recording;

  const RecordingDetailsScaffold(this.recording, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recording Details'),
      ),
      body: RecordingDetails(recording),
    );
  }
}