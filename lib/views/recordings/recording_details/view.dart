import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:meeting_minutes/data/symbl_api.dart';
import 'package:provider/provider.dart';

class RecordingDetails extends StatelessWidget {
  final Recording recording;

  const RecordingDetails(this.recording, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Card(
          child: ListTile(
            title: FutureBuilder(
              future: context.read<SymblApi>().getName(recording.job),
              builder: (context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  }
                  return const Text('Unknown');
                }
                return const Text('Loading');
              },
            ),
            subtitle: Text(recording.date.toString()),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Transcript'),
            subtitle: FutureBuilder(
              future: context.read<SymblApi>().getTranscript(recording.job),
              builder: (context, AsyncSnapshot<List<String>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.map((line) => Text(line)).toList(),
                    );
                  }
                  return const Text('Unknown');
                }
                return const Text('Loading');
              },
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Topics'),
            subtitle: FutureBuilder(
              future: context.read<SymblApi>().getTopics(recording.job),
              builder: (context, AsyncSnapshot<List<String>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.map((topic) => Text(topic)).toList(),
                    );
                  }
                  return const Text('Unknown');
                }
                return const Text('Loading');
              },
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Action Items'),
            subtitle: FutureBuilder(
              future: context.read<SymblApi>().getActionItems(recording.job),
              builder: (context, AsyncSnapshot<List<String>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.map((actionItem) => Text(actionItem)).toList(),
                    );
                  }
                  return const Text('Unknown');
                }
                return const Text('Loading');
              },
            ),
          ),
        ),
      ],
    );
  }
}