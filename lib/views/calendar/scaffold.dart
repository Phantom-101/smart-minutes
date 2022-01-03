import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/recording.dart';

import 'view.dart';

class CalendarScaffold extends StatelessWidget {
  final List<Recording> recordings;

  const CalendarScaffold(this.recordings, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Calendar(recordings),
    );
  }
}