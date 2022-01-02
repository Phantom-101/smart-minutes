import 'package:flutter/material.dart';

import 'view.dart';

class CreateRecordingScaffold extends StatelessWidget {
  const CreateRecordingScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recording'),
      ),
      body: CreateRecording(),
    );
  }
}