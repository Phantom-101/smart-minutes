import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:meeting_minutes/data/symbl_api.dart';
import 'package:meeting_minutes/views/recordings/recording_details/scaffold.dart';
import 'package:provider/provider.dart';

class RecordingInfo extends StatelessWidget {
  final Recording recording;

  const RecordingInfo(this.recording, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RecordingDetailsScaffold(recording)));
        },
        child: ListTile(
          title: FutureBuilder(
            future: context.read<SymblApi>().getName(recording.job),
            builder: (context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) return const Text('Unknown');
                return Text(snapshot.data!);
              }
              return const Text('Loading');
            },
          ),
          subtitle: Text(recording.date.toString()),
        ),
      ),
    );
  }
}