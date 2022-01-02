import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/recording.dart';

class RecordingInfo extends StatelessWidget {
  final Recording recording;

  const RecordingInfo(this.recording, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: ListTile(
          title: Text(recording.name),
          subtitle: Text(recording.description),
        ),
      ),
    );
  }
}