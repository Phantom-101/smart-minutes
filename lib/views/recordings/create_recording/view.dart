import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meeting_minutes/data/conversation_job.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:meeting_minutes/data/symbl_api.dart';
import 'package:meeting_minutes/data/team.dart';
import 'package:provider/provider.dart';

class CreateRecording extends StatefulWidget {
  final Team team;

  const CreateRecording(this.team, {Key? key}) : super(key: key);

  @override
  State<CreateRecording> createState() => _CreateRecordingState();
}

class _CreateRecordingState extends State<CreateRecording> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _speakers = TextEditingController();

  String? _path;

  bool _valid = false;
  bool _creating = false;

  @override
  Widget build(BuildContext context) {
    if (_creating) {
      return const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Uploading your recording...'),
          ),
        ),
      );
    }

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
        Center(
          child: SizedBox(
            width: 400,
            child: TextFormField(
              controller: _speakers,
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (int.tryParse(value ?? '') == null) {
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    setState(() {
                      _valid = false;
                    });
                  });
                  return 'Content must be a number';
                }
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  setState(() {
                    _valid = true;
                  });
                });
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Speakers',
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Center(
          child: SizedBox(
            width: 100,
            child: TextButton(
              onPressed: _valid ? () async {
                setState(() {
                  _creating = true;
                });
                if (_path != null) {
                  ConversationJob? job = await context.read<SymblApi>().sendAudio(_name.text, int.parse(_speakers.text), _path!);
                  if (job != null) {
                    await context.read<Database>().addRecording(widget.team, job);
                  }
                }
                Navigator.pop(context);
              } : null,
              child: const Text('Create'),
            ),
          ),
        ),
      ],
    );
  }
}