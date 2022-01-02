import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:meeting_minutes/views/recordings/recording_info/view.dart';

class RecordingList extends StatelessWidget {
  final List<Recording> recordings;

  const RecordingList(this.recordings, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: recordings.map((recording) => RecordingInfo(recording)).toList(),
    );
  }
}