import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/recording.dart';

import 'view.dart';

class RecordingListScaffold extends StatelessWidget {
  final List<Recording> recordings;

  const RecordingListScaffold(this.recordings, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordings'),
      ),
      body: RecordingList(recordings),
    );
  }
}