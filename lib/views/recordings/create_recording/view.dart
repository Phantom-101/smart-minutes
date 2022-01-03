import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateRecording extends StatefulWidget {
  const CreateRecording({Key? key}) : super(key: key);

  @override
  State<CreateRecording> createState() => _CreateRecordingState();
}

class _CreateRecordingState extends State<CreateRecording> {
  final TextEditingController _name = TextEditingController();

  String? _path;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 50),
        Center(
          child: SizedBox(
            width: 100,
            child: TextButton(
              onPressed: () async {
                var result = await FilePicker.platform.pickFiles(
                  type: FileType.audio,
                );
                if (result != null) {
                  setState(() {
                    _path = result.paths[0];
                  });
                }
              },
              child: const Text('Pick File'),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 100,
            child: Text(_path ?? 'No file'),
          ),
        ),
        const SizedBox(height: 50),
        Center(
          child: SizedBox(
            width: 400,
            child: TextField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Center(
          child: SizedBox(
            width: 100,
            child: TextButton(
              onPressed: () {
                if (_path != null) {
                  print(_path);
                }
              },
              child: const Text('Create'),
            ),
          ),
        ),
      ],
    );
  }
}